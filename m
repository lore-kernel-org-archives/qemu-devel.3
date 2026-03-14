Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 309A110854B4
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2026 23:43:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1Yd7-00032f-R6; Sat, 14 Mar 2026 19:42:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w1Yd6-00032W-Cm
 for qemu-devel@nongnu.org; Sat, 14 Mar 2026 19:42:48 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w1Yd3-0002nT-UH
 for qemu-devel@nongnu.org; Sat, 14 Mar 2026 19:42:48 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-35a288a2c00so797948a91.2
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2026 16:42:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773531764; cv=none;
 d=google.com; s=arc-20240605;
 b=Ui9HwQ+XWNzCN87EbG+iYyrUOuaJORIaISbiL3zvEceWd4qx45T/tYW7zgBHHoGQP6
 pCl7tApAKNoAsb1vnyZlq1o5PQ1oDVjQF1WPJa4ZjaKOwLaYR/CbuSyRo6Fonk7Xr847
 ANsfD7VzVvMnNksNJw6SjCKElpvkf6jQI+glOYGZidkwrWHaZjKezu+MbFRfXRCiYfEH
 ufBNCTaGUaCNTZMujjavbFt3oRfysH4hyuuo55ushnqFKNAaODEqnedtynhwObQdPlj2
 chl52fuax+KE/626VzJaaIs/c42JIHrIv0sjTPMRzbR+Z1fjyPvPqqzWEgUnXzavI8st
 xjYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9fwAqU0oyN1zoVvhbU0TmgcFBb/6GsULu5CiPBn6Y38=;
 fh=1o0IS21oykZAK9khT+jbOSqBIRa0XU54FaHjpHIDHfI=;
 b=PfArwcd4KYM/nOMpvZgSGTpyRG2BquP0GEs5rQSvTdj5TkU8TLH3FvfDsTKrL4KsGp
 52p9syhoFRog25SsLmiRls43MmQhmy6XjxLRR4sgiqMsvp/MDxdK1wdckkqKphAYfjj+
 tWFHnThyKqeqTEu97txieZJ5lnvvMo8+OY0CgyGx5SvVLx/DK84MDXK9oMvypoa/QTHS
 bTUKxnd7l4/bmyTG5h6p/sRzcclfgog2GHZs9qawzUa/R3O++UIx8dVlHG3XErPETQio
 fxJctX6A1dFlVJxh0JdhSdL1qH796E1gUV4wJhXK4ArpOvqGrqnN81IwdC98p6YyJBLS
 UYpQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773531764; x=1774136564; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9fwAqU0oyN1zoVvhbU0TmgcFBb/6GsULu5CiPBn6Y38=;
 b=e726SvjBPDxaDcDBKb+HzXeZZx/MFVjMFukp9S1USYM0ZzRxEbSqKkrQvGm5VzHLya
 UASQc/l7/MlaQcihb0JLOYQ9C4X4jJM9JyqTp5VLq118NkMattKw6urOkA8RMPUps+LS
 5aK1seY8Ot+cip4xWblqeR6RFDnWD4tFtCLnztxq5Wr6+xTgTQZB11Lj1+MdZXzLrF6c
 iml0adjb2Dsh9iMeuj67NMwEJyzXNt6YavDYT712Hm8bSUueaXbUWmSB5vgnBTvXffTl
 0ILX8pgTYcLJ6NRDlBc8vjFZ9acShQCL4K3fol3Mw+DlabNepko6F0CKC8DpZL0Fb94U
 Lpug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773531764; x=1774136564;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9fwAqU0oyN1zoVvhbU0TmgcFBb/6GsULu5CiPBn6Y38=;
 b=E+DZXxlkcHs6HfNi9/NKkYGcGBAUzjXg1kH8AKD2Lr/Ls8luU+VwuVmBCDGDz6vJD3
 7lJxWEQSpIBrE8Is1mW3GIxse37yKhxTO6ZmT7B1c73WqGlv/kUkyNeSzc0a1Z2d8Clx
 BuikCj/fiQb0mPGAodNzTbX12YoXkr2n4CatdUY1WgHkb1OJlvhOuh0vLRH31BAaUwr3
 FSgDbRrDyQkza8ai+rSiuDCmXCTf1I8RIcS6PlWIhyI2ZyO45n/5AqdEpxpIpF4UblQ/
 KY/oq8kEdudPJlj4HSwayGpUjjEzLzo/2SoVVkkWEgzfQm+epbxHbzsgA6ayhjMdOsDR
 I/tg==
X-Gm-Message-State: AOJu0YwOYVKZnLNTPJEBzLtVQwgepV8Ck+oKdy8KkmGCJ0DHBQxhdnhR
 E4u9zg5O++O7wBSgN3OCb499z4LeBUvL52HaM3kQHfYbYE1whSVnz95RfqXBNL44ff403T8w3c8
 qNG4ZndOmAnzGkniVXQlrgQ5tAaEQuI0=
X-Gm-Gg: ATEYQzwsdrTmFhl/COLhHPqUA2xCLG8FuuHy78pDtxWGNJozrrSLgpYsuGEth/hJSNn
 AOpe+4TrKEN3ugsdVTChhhYR+yAUdmFsfQt+zD4MEg7+QspdgP5lLLeAdPAhaAHiQDiXwrXdbml
 1BPDqi2oN3epgjPDWCZjCf2TZtlcpXmdmTen7A/y8zfaabIGSWp5IwvXNYPoWnLDmqBML6VUMKM
 oW4gCRSXKbvu3ihj9XR7TJFFUcDIiTs48Od8XG/Y8v/Yj7TchvRMDg73Q+u6KCcw4Z3Z/q2tk6j
 uDCfKmcAaD+LJroMSlCvVX/63BmdDk6ZERGc1u9HJDIYwD0ceg==
X-Received: by 2002:a17:90b:5284:b0:359:1063:6aed with SMTP id
 98e67ed59e1d1-35a22003d20mr6904982a91.22.1773531763708; Sat, 14 Mar 2026
 16:42:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
 <20260311040758.1068731-10-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260311040758.1068731-10-brian.cain@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Sat, 14 Mar 2026 17:42:32 -0600
X-Gm-Features: AaiRm53Ib-81pP3sWjBX2xj_XrWwvE_NVT8XlFRdppVejvfEA785LTvH4Xk7KBs
Message-ID: <CAATN3NpCZxriBWDz5Ssn2RA5hJ2eLVzRtSV+03sw3tEQt+0oTg@mail.gmail.com>
Subject: Re: [PATCH v3 09/32] target/hexagon: Add implementation of cycle
 counters
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com, 
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng, 
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>, Sid Manning <sidneym@quicinc.com>
Content-Type: multipart/alternative; boundary="000000000000c61496064d048a70"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000c61496064d048a70
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 10:08=E2=80=AFPM Brian Cain <brian.cain@oss.qualcom=
m.com>
wrote:

> From: Brian Cain <bcain@quicinc.com>
>
> The PCYCLE register is available in system mode, but only increments
> when the SYSCFG.PCYCLEEN field is set.
>
> The UPCYCLE register is available in user mode and we model it
> unconditionally in linux-user emulation, as if the system had enabled
> PCYCCLEEN.
>
> For now, the model is very crudely counting the sum of instructions
> executed among vCPUs, regardless of how the instructions were actually
> scheduled.  This is sufficient for demonstrating a rough level of
> activity but will be particularly misleading for benchmarks and performan=
ce
> tuning.  We may decide to revisit this model in order to give more
> a bit more fidelity, though without a cache model it would still be very
> far
> from accurate.
>
> Co-authored-by: Sid Manning <sidneym@quicinc.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/cpu.h        |  5 +++--
>  target/hexagon/translate.h  |  2 ++
>  target/hexagon/cpu.c        | 14 ++++++++++++++
>  target/hexagon/cpu_helper.c | 32 ++++++++++++++++++++++++++++----
>  target/hexagon/translate.c  | 21 +++++++++++++++++++++
>  5 files changed, 68 insertions(+), 6 deletions(-)
>
> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
> index 20c4b82a970..1c8a188dec4 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -293,9 +293,23 @@ static TCGTBCPUState
> hexagon_get_tb_cpu_state(CPUState *cs)
>      }
>
>  #ifndef CONFIG_USER_ONLY
> +    HexagonCPU *cpu =3D env_archcpu(env);
> +    uint32_t syscfg =3D cpu->globalregs ?
> +        hexagon_globalreg_read(cpu->globalregs, HEX_SREG_SYSCFG,
> +                               env->threadId) : 0;
> +
> +    bool pcycle_enabled =3D extract32(syscfg,
> +
> reg_field_info[SYSCFG_PCYCLEEN].offset,
> +
> reg_field_info[SYSCFG_PCYCLEEN].width);
> +
>      hex_flags =3D FIELD_DP32(hex_flags, TB_FLAGS, MMU_INDEX,
>                             cpu_mmu_index(env_cpu(env), false));
> +
> +    if (pcycle_enabled) {
> +        hex_flags =3D FIELD_DP32(hex_flags, TB_FLAGS, PCYCLE_ENABLED, 1)=
;
> +    }
>  #else
> +    hex_flags =3D FIELD_DP32(hex_flags, TB_FLAGS, PCYCLE_ENABLED, true);
>

I notice we are setting pcycle-enabled here under CONFIG_USER_ONLY.  See
below ...


>      hex_flags =3D FIELD_DP32(hex_flags, TB_FLAGS, MMU_INDEX, MMU_USER_ID=
X);
>  #endif
>
> diff --git a/target/hexagon/cpu_helper.c b/target/hexagon/cpu_helper.c
> index 4860e4a6ab0..729ffa47eed 100644
> --- a/target/hexagon/cpu_helper.c
> +++ b/target/hexagon/cpu_helper.c
> @@ -33,17 +33,31 @@ uint32_t hexagon_get_pmu_counter(CPUHexagonState
> *cur_env, int index)
>
>  uint64_t hexagon_get_sys_pcycle_count(CPUHexagonState *env)
>  {
> -    g_assert_not_reached();
> +    BQL_LOCK_GUARD();
> +    uint32_t ssr =3D env->t_sreg[HEX_SREG_SSR];
> +    if (!GET_SSR_FIELD(SSR_CE, ssr)) {
> +        return 0;
> +    }
> +    uint64_t cycles =3D 0;
> +    CPUState *cs;
> +    CPU_FOREACH(cs) {
> +        CPUHexagonState *thread_env =3D cpu_env(cs);
> +        cycles +=3D thread_env->t_cycle_count;
> +    }
> +    HexagonCPU *cpu =3D env_archcpu(env);
> +    uint64_t base =3D cpu->globalregs ?
> +        hexagon_globalreg_get_pcycle_base(cpu->globalregs) : 0;
> +    return base + cycles;
>  }
>
>  uint32_t hexagon_get_sys_pcycle_count_high(CPUHexagonState *env)
>  {
> -    g_assert_not_reached();
> +    return hexagon_get_sys_pcycle_count(env) >> 32;
>  }
>
>  uint32_t hexagon_get_sys_pcycle_count_low(CPUHexagonState *env)
>  {
> -    g_assert_not_reached();
> +    return extract64(hexagon_get_sys_pcycle_count(env), 0, 32);
>  }
>
>  void hexagon_set_sys_pcycle_count_high(CPUHexagonState *env,
> @@ -60,7 +74,17 @@ void hexagon_set_sys_pcycle_count_low(CPUHexagonState
> *env,
>
>  void hexagon_set_sys_pcycle_count(CPUHexagonState *env, uint64_t cycles)
>  {
> -    g_assert_not_reached();
> +    BQL_LOCK_GUARD();
> +    HexagonCPU *cpu =3D env_archcpu(env);
> +    if (cpu->globalregs) {
> +        hexagon_globalreg_set_pcycle_base(cpu->globalregs, cycles);
> +    }
> +
> +    CPUState *cs;
> +    CPU_FOREACH(cs) {
> +        CPUHexagonState *thread_env =3D cpu_env(cs);
> +        thread_env->t_cycle_count =3D 0;
> +    }
>  }
>
>  void hexagon_modify_ssr(CPUHexagonState *env, uint32_t new, uint32_t old=
)
> diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
> index 4df4226cbcb..e4d4dad8ffd 100644
> --- a/target/hexagon/translate.c
> +++ b/target/hexagon/translate.c
> @@ -61,6 +61,7 @@ TCGv_i64 hex_store_val64[STORES_MAX];
>  TCGv hex_llsc_addr;
>  TCGv hex_llsc_val;
>  TCGv_i64 hex_llsc_val_i64;
> +TCGv_i64 hex_cycle_count;
>  TCGv hex_vstore_addr[VSTORES_MAX];
>  TCGv hex_vstore_size[VSTORES_MAX];
>  TCGv hex_vstore_pending[VSTORES_MAX];
> @@ -128,6 +129,16 @@ static void gen_exception_raw(int excp)
>      gen_helper_raise_exception(tcg_env, tcg_constant_i32(excp));
>  }
>
> +#ifndef CONFIG_USER_ONLY
> +static inline void gen_pcycle_counters(DisasContext *ctx)
> +{
> +    if (ctx->pcycle_enabled) {
> +        tcg_gen_addi_i64(hex_cycle_count, hex_cycle_count,
> ctx->num_cycles);
> +        ctx->num_cycles =3D 0;
> +    }
> +}
> +#endif
> +
>

But here, this is guarded by #ifndef CONFIG_USER_ONLY.


>  static void gen_exec_counters(DisasContext *ctx)
>  {
>      tcg_gen_addi_tl(hex_gpr[HEX_REG_QEMU_PKT_CNT],
> @@ -136,6 +147,10 @@ static void gen_exec_counters(DisasContext *ctx)
>                      hex_gpr[HEX_REG_QEMU_INSN_CNT], ctx->num_insns);
>      tcg_gen_addi_tl(hex_gpr[HEX_REG_QEMU_HVX_CNT],
>                      hex_gpr[HEX_REG_QEMU_HVX_CNT], ctx->num_hvx_insns);
> +
> +#ifndef CONFIG_USER_ONLY
> +   gen_pcycle_counters(ctx);
> +#endif
>

And here

Since much of the above won't work under CONFIG_USER_ONLY (e.g.,
CPU_FOREACH), it's best to keep all of this guarded by #ifndef
CONFIG_USER_ONLY.


>  }
>
>  static bool use_goto_tb(DisasContext *ctx, target_ulong dest)
> @@ -821,6 +836,7 @@ static void gen_commit_hvx(DisasContext *ctx)
>      }
>  }
>
> +static const int PCYCLES_PER_PACKET =3D 3;
>  static void update_exec_counters(DisasContext *ctx)
>  {
>      Packet *pkt =3D ctx->pkt;
> @@ -840,6 +856,7 @@ static void update_exec_counters(DisasContext *ctx)
>      }
>
>      ctx->num_packets++;
> +    ctx->num_cycles +=3D PCYCLES_PER_PACKET;
>      ctx->num_insns +=3D num_real_insns;
>      ctx->num_hvx_insns +=3D num_hvx_insns;
>  }
> @@ -989,11 +1006,13 @@ static void
> hexagon_tr_init_disas_context(DisasContextBase *dcbase,
>
>      ctx->mem_idx =3D FIELD_EX32(hex_flags, TB_FLAGS, MMU_INDEX);
>      ctx->num_packets =3D 0;
> +    ctx->num_cycles =3D 0;
>      ctx->num_insns =3D 0;
>      ctx->num_hvx_insns =3D 0;
>      ctx->branch_cond =3D TCG_COND_NEVER;
>      ctx->is_tight_loop =3D FIELD_EX32(hex_flags, TB_FLAGS, IS_TIGHT_LOOP=
);
>      ctx->short_circuit =3D hex_cpu->short_circuit;
> +    ctx->pcycle_enabled =3D FIELD_EX32(hex_flags, TB_FLAGS, PCYCLE_ENABL=
ED);
>  }
>
>  static void hexagon_tr_tb_start(DisasContextBase *db, CPUState *cpu)
> @@ -1136,6 +1155,8 @@ void hexagon_translate_init(void)
>          offsetof(CPUHexagonState, llsc_val), "llsc_val");
>      hex_llsc_val_i64 =3D tcg_global_mem_new_i64(tcg_env,
>          offsetof(CPUHexagonState, llsc_val_i64), "llsc_val_i64");
> +    hex_cycle_count =3D tcg_global_mem_new_i64(tcg_env,
> +            offsetof(CPUHexagonState, t_cycle_count), "t_cycle_count");
>

The t_cycle_count was added to CPUHexagonState in a different patch.  The
above statement as well as t_cycle_count should be guarded by #ifndef
CONFIG_USER_ONLY.

Otherwise
Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>

--000000000000c61496064d048a70
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 10,=
 2026 at 10:08=E2=80=AFPM Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.q=
ualcomm.com">brian.cain@oss.qualcomm.com</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">From: Brian Cain &lt;<a href=3D"mai=
lto:bcain@quicinc.com" target=3D"_blank">bcain@quicinc.com</a>&gt;<br>
<br>
The PCYCLE register is available in system mode, but only increments<br>
when the SYSCFG.PCYCLEEN field is set.<br>
<br>
The UPCYCLE register is available in user mode and we model it<br>
unconditionally in linux-user emulation, as if the system had enabled<br>
PCYCCLEEN.<br>
<br>
For now, the model is very crudely counting the sum of instructions<br>
executed among vCPUs, regardless of how the instructions were actually<br>
scheduled.=C2=A0 This is sufficient for demonstrating a rough level of<br>
activity but will be particularly misleading for benchmarks and performance=
<br>
tuning.=C2=A0 We may decide to revisit this model in order to give more<br>
a bit more fidelity, though without a cache model it would still be very fa=
r<br>
from accurate.<br>
<br>
Co-authored-by: Sid Manning &lt;<a href=3D"mailto:sidneym@quicinc.com" targ=
et=3D"_blank">sidneym@quicinc.com</a>&gt;<br>
Signed-off-by: Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcomm.com=
" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
---<br>
=C2=A0target/hexagon/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 5 +++--<br>
=C2=A0target/hexagon/translate.h=C2=A0 |=C2=A0 2 ++<br>
=C2=A0target/hexagon/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 14 ++++++++++++++<b=
r>
=C2=A0target/hexagon/cpu_helper.c | 32 ++++++++++++++++++++++++++++----<br>
=C2=A0target/hexagon/translate.c=C2=A0 | 21 +++++++++++++++++++++<br>
=C2=A05 files changed, 68 insertions(+), 6 deletions(-)<br>
<br>diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c<br>
index 20c4b82a970..1c8a188dec4 100644<br>
--- a/target/hexagon/cpu.c<br>
+++ b/target/hexagon/cpu.c<br>
@@ -293,9 +293,23 @@ static TCGTBCPUState hexagon_get_tb_cpu_state(CPUState=
 *cs)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0#ifndef CONFIG_USER_ONLY<br>
+=C2=A0 =C2=A0 HexagonCPU *cpu =3D env_archcpu(env);<br>
+=C2=A0 =C2=A0 uint32_t syscfg =3D cpu-&gt;globalregs ?<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 hexagon_globalreg_read(cpu-&gt;globalregs, HEX=
_SREG_SYSCFG,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;threadId) : 0;<br>
+<br>
+=C2=A0 =C2=A0 bool pcycle_enabled =3D extract32(syscfg,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg_field_info[SYSCFG_=
PCYCLEEN].offset,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg_field_info[SYSCFG_=
PCYCLEEN].width);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0hex_flags =3D FIELD_DP32(hex_flags, TB_FLAGS, MMU_INDEX=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 cpu_mmu_index(env_cpu(env), false));<br>
+<br>
+=C2=A0 =C2=A0 if (pcycle_enabled) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 hex_flags =3D FIELD_DP32(hex_flags, TB_FLAGS, =
PCYCLE_ENABLED, 1);<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0#else<br>
+=C2=A0 =C2=A0 hex_flags =3D FIELD_DP32(hex_flags, TB_FLAGS, PCYCLE_ENABLED=
, true);<br></blockquote><div><br></div><div>I notice we are setting pcycle=
-enabled here under CONFIG_USER_ONLY.=C2=A0 See below ...</div><div>=C2=A0<=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0hex_flags =3D FIELD_DP32(hex_flags, TB_FLAGS, MMU_INDEX=
, MMU_USER_IDX);<br>
=C2=A0#endif<br>
<br>
diff --git a/target/hexagon/cpu_helper.c b/target/hexagon/cpu_helper.c<br>
index 4860e4a6ab0..729ffa47eed 100644<br>
--- a/target/hexagon/cpu_helper.c<br>
+++ b/target/hexagon/cpu_helper.c<br>
@@ -33,17 +33,31 @@ uint32_t hexagon_get_pmu_counter(CPUHexagonState *cur_e=
nv, int index)<br>
<br>
=C2=A0uint64_t hexagon_get_sys_pcycle_count(CPUHexagonState *env)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 g_assert_not_reached();<br>
+=C2=A0 =C2=A0 BQL_LOCK_GUARD();<br>
+=C2=A0 =C2=A0 uint32_t ssr =3D env-&gt;t_sreg[HEX_SREG_SSR];<br>
+=C2=A0 =C2=A0 if (!GET_SSR_FIELD(SSR_CE, ssr)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 uint64_t cycles =3D 0;<br>
+=C2=A0 =C2=A0 CPUState *cs;<br>
+=C2=A0 =C2=A0 CPU_FOREACH(cs) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 CPUHexagonState *thread_env =3D cpu_env(cs);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cycles +=3D thread_env-&gt;t_cycle_count;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 HexagonCPU *cpu =3D env_archcpu(env);<br>
+=C2=A0 =C2=A0 uint64_t base =3D cpu-&gt;globalregs ?<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 hexagon_globalreg_get_pcycle_base(cpu-&gt;glob=
alregs) : 0;<br>
+=C2=A0 =C2=A0 return base + cycles;<br>
=C2=A0}<br>
<br>
=C2=A0uint32_t hexagon_get_sys_pcycle_count_high(CPUHexagonState *env)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 g_assert_not_reached();<br>
+=C2=A0 =C2=A0 return hexagon_get_sys_pcycle_count(env) &gt;&gt; 32;<br>
=C2=A0}<br>
<br>
=C2=A0uint32_t hexagon_get_sys_pcycle_count_low(CPUHexagonState *env)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 g_assert_not_reached();<br>
+=C2=A0 =C2=A0 return extract64(hexagon_get_sys_pcycle_count(env), 0, 32);<=
br>
=C2=A0}<br>
<br>
=C2=A0void hexagon_set_sys_pcycle_count_high(CPUHexagonState *env,<br>
@@ -60,7 +74,17 @@ void hexagon_set_sys_pcycle_count_low(CPUHexagonState *e=
nv,<br>
<br>
=C2=A0void hexagon_set_sys_pcycle_count(CPUHexagonState *env, uint64_t cycl=
es)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 g_assert_not_reached();<br>
+=C2=A0 =C2=A0 BQL_LOCK_GUARD();<br>
+=C2=A0 =C2=A0 HexagonCPU *cpu =3D env_archcpu(env);<br>
+=C2=A0 =C2=A0 if (cpu-&gt;globalregs) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 hexagon_globalreg_set_pcycle_base(cpu-&gt;glob=
alregs, cycles);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 CPUState *cs;<br>
+=C2=A0 =C2=A0 CPU_FOREACH(cs) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 CPUHexagonState *thread_env =3D cpu_env(cs);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 thread_env-&gt;t_cycle_count =3D 0;<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0}<br>
<br>
=C2=A0void hexagon_modify_ssr(CPUHexagonState *env, uint32_t new, uint32_t =
old)<br>
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c<br>
index 4df4226cbcb..e4d4dad8ffd 100644<br>
--- a/target/hexagon/translate.c<br>
+++ b/target/hexagon/translate.c<br>
@@ -61,6 +61,7 @@ TCGv_i64 hex_store_val64[STORES_MAX];<br>
=C2=A0TCGv hex_llsc_addr;<br>
=C2=A0TCGv hex_llsc_val;<br>
=C2=A0TCGv_i64 hex_llsc_val_i64;<br>
+TCGv_i64 hex_cycle_count;<br>
=C2=A0TCGv hex_vstore_addr[VSTORES_MAX];<br>
=C2=A0TCGv hex_vstore_size[VSTORES_MAX];<br>
=C2=A0TCGv hex_vstore_pending[VSTORES_MAX];<br>
@@ -128,6 +129,16 @@ static void gen_exception_raw(int excp)<br>
=C2=A0 =C2=A0 =C2=A0gen_helper_raise_exception(tcg_env, tcg_constant_i32(ex=
cp));<br>
=C2=A0}<br>
<br>
+#ifndef CONFIG_USER_ONLY<br>
+static inline void gen_pcycle_counters(DisasContext *ctx)<br>
+{<br>
+=C2=A0 =C2=A0 if (ctx-&gt;pcycle_enabled) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_addi_i64(hex_cycle_count, hex_cycle_co=
unt, ctx-&gt;num_cycles);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx-&gt;num_cycles =3D 0;<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+#endif<br>
+<br></blockquote><div><br></div><div>But here, this is guarded by #ifndef =
CONFIG_USER_ONLY.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">
=C2=A0static void gen_exec_counters(DisasContext *ctx)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0tcg_gen_addi_tl(hex_gpr[HEX_REG_QEMU_PKT_CNT],<br>
@@ -136,6 +147,10 @@ static void gen_exec_counters(DisasContext *ctx)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0hex_gpr[HEX_REG_QEMU_INSN_CNT], ctx-&gt;num_insns);<br>
=C2=A0 =C2=A0 =C2=A0tcg_gen_addi_tl(hex_gpr[HEX_REG_QEMU_HVX_CNT],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0hex_gpr[HEX_REG_QEMU_HVX_CNT], ctx-&gt;num_hvx_insns);<br>
+<br>
+#ifndef CONFIG_USER_ONLY<br>
+=C2=A0 =C2=A0gen_pcycle_counters(ctx);<br>
+#endif<br></blockquote><div><br></div><div>And here</div><div><br></div><d=
iv>Since much of the above won&#39;t work under CONFIG_USER_ONLY (e.g., CPU=
_FOREACH), it&#39;s best to keep all of this guarded by #ifndef CONFIG_USER=
_ONLY.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">
=C2=A0}<br>
<br>
=C2=A0static bool use_goto_tb(DisasContext *ctx, target_ulong dest)<br>
@@ -821,6 +836,7 @@ static void gen_commit_hvx(DisasContext *ctx)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
+static const int PCYCLES_PER_PACKET =3D 3;<br>
=C2=A0static void update_exec_counters(DisasContext *ctx)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0Packet *pkt =3D ctx-&gt;pkt;<br>
@@ -840,6 +856,7 @@ static void update_exec_counters(DisasContext *ctx)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0ctx-&gt;num_packets++;<br>
+=C2=A0 =C2=A0 ctx-&gt;num_cycles +=3D PCYCLES_PER_PACKET;<br>
=C2=A0 =C2=A0 =C2=A0ctx-&gt;num_insns +=3D num_real_insns;<br>
=C2=A0 =C2=A0 =C2=A0ctx-&gt;num_hvx_insns +=3D num_hvx_insns;<br>
=C2=A0}<br>
@@ -989,11 +1006,13 @@ static void hexagon_tr_init_disas_context(DisasConte=
xtBase *dcbase,<br>
<br>
=C2=A0 =C2=A0 =C2=A0ctx-&gt;mem_idx =3D FIELD_EX32(hex_flags, TB_FLAGS, MMU=
_INDEX);<br>
=C2=A0 =C2=A0 =C2=A0ctx-&gt;num_packets =3D 0;<br>
+=C2=A0 =C2=A0 ctx-&gt;num_cycles =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0ctx-&gt;num_insns =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0ctx-&gt;num_hvx_insns =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0ctx-&gt;branch_cond =3D TCG_COND_NEVER;<br>
=C2=A0 =C2=A0 =C2=A0ctx-&gt;is_tight_loop =3D FIELD_EX32(hex_flags, TB_FLAG=
S, IS_TIGHT_LOOP);<br>
=C2=A0 =C2=A0 =C2=A0ctx-&gt;short_circuit =3D hex_cpu-&gt;short_circuit;<br=
>
+=C2=A0 =C2=A0 ctx-&gt;pcycle_enabled =3D FIELD_EX32(hex_flags, TB_FLAGS, P=
CYCLE_ENABLED);<br>
=C2=A0}<br>
<br>
=C2=A0static void hexagon_tr_tb_start(DisasContextBase *db, CPUState *cpu)<=
br>
@@ -1136,6 +1155,8 @@ void hexagon_translate_init(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0offsetof(CPUHexagonState, llsc_val), &quo=
t;llsc_val&quot;);<br>
=C2=A0 =C2=A0 =C2=A0hex_llsc_val_i64 =3D tcg_global_mem_new_i64(tcg_env,<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0offsetof(CPUHexagonState, llsc_val_i64), =
&quot;llsc_val_i64&quot;);<br>
+=C2=A0 =C2=A0 hex_cycle_count =3D tcg_global_mem_new_i64(tcg_env,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 offsetof(CPUHexagonState, t_cycl=
e_count), &quot;t_cycle_count&quot;);<br></blockquote><div><br></div><div>T=
he t_cycle_count was added to CPUHexagonState in a different patch.=C2=A0 T=
he above statement as well as t_cycle_count should be guarded by #ifndef CO=
NFIG_USER_ONLY.</div><div><br></div><div>Otherwise</div><div>Reviewed-by: T=
aylor Simpson &lt;<a href=3D"mailto:ltaylorsimpson@gmail.com">ltaylorsimpso=
n@gmail.com</a>&gt;</div></div></div>

--000000000000c61496064d048a70--

