Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9C6ED2ECFD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 02:13:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vi1Ew-00044n-LL; Mon, 19 Jan 2026 21:13:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vi1Eu-0003zX-KE
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 21:13:04 -0500
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vi1Es-0000q0-8S
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 21:13:04 -0500
Received: by mail-pj1-x1043.google.com with SMTP id
 98e67ed59e1d1-34c3cb504efso3236594a91.2
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 18:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768875181; x=1769479981; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8EGjELkMI98mNu6dKfWVs5iLh49WUDF7MEMpQ3OwBP4=;
 b=ATtktkAuoZtUFb5SpF7eIxacWsu+qeV3Y3hl5n2GSwwHGhKU2IRVd9Tg8g15VkDm5i
 TREgNLTYTYuO54h/gavNfVbWHSWrErMOhSmAbiP54t9lSzPrEbqcqXP3p7hjPS54QFwi
 qMi1mNWHVepA+071nZfIy68vhecQNU2UQ/CRQM1LAsmlqS2OTae3XjPgUOmLTnXwP/80
 L+tf/u8ucA7940UKZ1o5OcEoLHC0vtzaRkR32P/mf+Byb1H71QOj1zQWPS/6y5Mv9mGa
 lewnEQd7U5YAknH52L7P50EBdbaS92hp4aOu/w88IBGMaAkdEwcrNVrAfbtIcDFpPOLJ
 L7Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768875181; x=1769479981;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8EGjELkMI98mNu6dKfWVs5iLh49WUDF7MEMpQ3OwBP4=;
 b=Tqls3ERE/Y0ZK1EbnNn7KpnuKwvetwhz/rbBZKLz3RvykSQPkyu2taLXUHd9Y8yjON
 XVh+eQqX8yCnPVRsaQC9Vux7UdvgZJ4JPvoL84j2PDvhErUcwPq+d67+zFv04EqgR3Hg
 5+DfVDnDuVWepdCVWq3mLWyBBhdFMov+Q9NHNxehle999fhZkaNSkiGRC8y5xsqFBKwZ
 vzQ5ocAVUoqcUuBc46HIcjd7vLMUYeonJpDhhVI9vjDF5qKNif0dS8Z63mgyU4bOoH/n
 I/0ZK0ahucwEXqcCz/0QEIdqSrJEbGfUh9Noj70ZELVrQ74XZ9inQqsE4vSw2QMO/fSe
 /Fqw==
X-Gm-Message-State: AOJu0YymA5MzVMr1WCXyQe1DT9afuiYVfk+ZD4fl88NupTgMaqegzgfW
 IQ+67jlwMj37ny9mdBfZ4ew/3HEppE1oHKRtSmA9jD8ImCzx13paUCEp
X-Gm-Gg: AZuq6aJZiFmshF+Fncsftp8DH2wnZW2ffn+O18hApr14zeK0MkiCFt4Arsi0sS5raEH
 qwDdJNBb97caXIlu0QyeGjekExPadE3tALwj63F8mnbkh2ac1qqu+Y1zsiiZHYGpbUSvLsxq0vS
 KKrMAtfrn5MLAO9inppAVTZbTc1fpH+RkXho7A7RuMHE+UaY8NRPlkVnZU5wuARX6SX8coJO977
 8/E2jZ2fNJDs+SjUpj+iGMURkwBudxj5STGU7MSYTcx390RzkJ2vmLrH+G6f+AjneA7Fuj4zjiQ
 NaSHX2njPapcCIZZ0bq8OzAAwP+C7e//spM7UD1hp0KgrO9wtG7b637i4oYCw2zZ+/c8zR3Xrvb
 gt+W9Jzs0zmtCkhcBH1qDf1Rhe6WN3JUkY7MuoJENno8w8THdDtRJdKJxqk3Wj3e48dCAHVqowt
 idNkuYjFdSPNcdehQetfimjXwwDbuWZGdZFNugyQjf1xlxvs8bUUiOQWpACxY=
X-Received: by 2002:a17:90b:568d:b0:349:5b1b:78be with SMTP id
 98e67ed59e1d1-352732551d2mr11749404a91.17.1768875180411; 
 Mon, 19 Jan 2026 18:13:00 -0800 (PST)
Received: from [127.0.0.1] ([218.81.29.112]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3527402f5b8sm5435749a91.1.2026.01.19.18.12.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jan 2026 18:12:59 -0800 (PST)
Message-ID: <a67b6281-52e9-4f0e-bef0-ef9823a8e2c5@gmail.com>
Date: Tue, 20 Jan 2026 10:12:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 6/8] riscv: add sdext single-step support
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, wangjingwei@iscas.ac.cn
References: <cover.1768622881.git.chao.liu.zevorn@gmail.com>
 <ce55286638a7c4bcfc6a9627151fdc3bd808077b.1768622882.git.chao.liu.zevorn@gmail.com>
From: Chao Liu <chao.liu.zevorn@gmail.com>
In-Reply-To: <ce55286638a7c4bcfc6a9627151fdc3bd808077b.1768622882.git.chao.liu.zevorn@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pj1-x1043.google.com
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



On 1/17/2026 12:27 PM, Chao Liu wrote:
> RISC-V Debug Specification:
> https://github.com/riscv/riscv-debug-spec/releases/tag/1.0
> 
> Use a TB flag when dcsr.step is set (and we are not in Debug Mode).
> When the flag is on, build 1-insn TBs and do not chain to the next TB.
> Add a TB-exit helper that enters Debug Mode with cause=step and sets
> dpc to the next pc, then stops with EXCP_DEBUG.
> 
> If dcsr.stepie is 0, do not take interrupts while stepping. Treat WFI
> as a nop so the hart does not sleep during a step.
> 
> PS: This patch references Max Chou's handling of ext_tb_flags.
> https://lore.kernel.org/qemu-devel/20260108132631.9429-6-max.chou@sifive.com/
> 
> Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
> ---
>  include/exec/translation-block.h |  3 ++-
>  target/riscv/cpu.h               |  3 +++
>  target/riscv/cpu_helper.c        |  6 ++++++
>  target/riscv/csr.c               | 21 +++++++--------------
>  target/riscv/helper.h            |  1 +
>  target/riscv/op_helper.c         | 20 ++++++++++++++++++++
>  target/riscv/tcg/tcg-cpu.c       |  9 ++++++++-
>  target/riscv/translate.c         | 16 ++++++++++++++--
>  8 files changed, 61 insertions(+), 18 deletions(-)
> 
> diff --git a/include/exec/translation-block.h b/include/exec/translation-block.h
> index cdce399eba..75188f56c8 100644
> --- a/include/exec/translation-block.h
> +++ b/include/exec/translation-block.h
> @@ -62,7 +62,8 @@ struct TranslationBlock {
>       * x86: the original user, the Code Segment virtual base,
>       * arm: an extension of tb->flags,
>       * s390x: instruction data for EXECUTE,
> -     * sparc: the next pc of the instruction queue (for delay slots).
> +     * sparc: the next pc of the instruction queue (for delay slots),
> +     * riscv: an extension of tb->flags.
>       */
>      uint64_t cs_base;
>  
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index ca861aa5f8..fe37ae8458 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -712,6 +712,9 @@ FIELD(TB_FLAGS, BCFI_ENABLED, 28, 1)
>  FIELD(TB_FLAGS, PM_PMM, 29, 2)
>  FIELD(TB_FLAGS, PM_SIGNEXTEND, 31, 1)
>  
> +/* sdext single-step needs a TB flag to build 1-insn TBs */
> +FIELD(EXT_TB_FLAGS, SDEXT_STEP, 33, 1)
> +
>  #ifdef TARGET_RISCV32
>  #define riscv_cpu_mxl(env)  ((void)(env), MXL_RV32)
>  #else
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 83d2aa1b75..d8905a5a1e 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -638,6 +638,12 @@ bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
>      if (interrupt_request & mask) {
>          RISCVCPU *cpu = RISCV_CPU(cs);
>          CPURISCVState *env = &cpu->env;
> +
> +        if (cpu->cfg.ext_sdext && !env->debug_mode &&
> +            (env->dcsr & DCSR_STEP) && !(env->dcsr & DCSR_STEPIE)) {
> +            return false;
> +        }
> +
>          int interruptno = riscv_cpu_local_irq_pending(env);
>          if (interruptno >= 0) {
>              cs->exception_index = RISCV_EXCP_INT_FLAG | interruptno;
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 4a732b9364..8dff9615c4 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -3171,15 +3171,10 @@ static RISCVException write_mtval(CPURISCVState *env, int csrno,
>      return RISCV_EXCP_NONE;
>  }
>  
> -#ifndef CONFIG_USER_ONLY
> -static bool riscv_sdext_available(CPURISCVState *env)
> -{
> -    return riscv_cpu_cfg(env)->ext_sdext;
> -}
> -
> -static RISCVException dcsr_predicate(CPURISCVState *env, int csrno)
> +#if !defined(CONFIG_USER_ONLY)
> +static RISCVException sdext(CPURISCVState *env, int csrno)
This change should apply patch 2 ("riscv: add sdext debug CSRs state").

I will fix it in v2.
>  {
> -    if (!riscv_sdext_available(env)) {
> +    if (!riscv_cpu_cfg(env)->ext_sdext) {
>          return RISCV_EXCP_ILLEGAL_INST;
>      }
>  
> @@ -6440,12 +6435,10 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
>      [CSR_TINFO]     =  { "tinfo",    sdtrig, read_tinfo,    write_ignore   },
>      [CSR_MCONTEXT]  =  { "mcontext", sdtrig, read_mcontext, write_mcontext },
>  #if !defined(CONFIG_USER_ONLY)
> -    [CSR_DCSR]      =  { "dcsr", dcsr_predicate, read_dcsr, write_dcsr },
> -    [CSR_DPC]       =  { "dpc", dcsr_predicate, read_dpc, write_dpc },
> -    [CSR_DSCRATCH]  =  { "dscratch0", dcsr_predicate,
> -                         read_dscratch, write_dscratch },
> -    [CSR_DSCRATCH1] =  { "dscratch1", dcsr_predicate,
> -                         read_dscratch, write_dscratch },
> +    [CSR_DCSR]      =  { "dcsr",      sdext, read_dcsr,     write_dcsr },
> +    [CSR_DPC]       =  { "dpc",       sdext, read_dpc,      write_dpc },
> +    [CSR_DSCRATCH]  =  { "dscratch0", sdext, read_dscratch, write_dscratch },
> +    [CSR_DSCRATCH1] =  { "dscratch1", sdext, read_dscratch, write_dscratch },
As mentioned above.

Thanks,
Chao
>  #endif
>  
>      [CSR_MCTRCTL]    = { "mctrctl",    ctr_mmode,  NULL, NULL, rmw_xctrctl    },
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index acff73051b..0b709c2b99 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -141,6 +141,7 @@ DEF_HELPER_1(tlb_flush_all, void, env)
>  DEF_HELPER_4(ctr_add_entry, void, env, tl, tl, tl)
>  /* Native Debug */
>  DEF_HELPER_1(itrigger_match, void, env)
> +DEF_HELPER_1(sdext_step, void, env)
>  DEF_HELPER_2(sdext_ebreak, void, env, tl)
>  #endif
>  
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index dfe5388ab7..6fe29ce905 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -470,6 +470,22 @@ target_ulong helper_dret(CPURISCVState *env)
>  #endif
>  }
>  
> +void helper_sdext_step(CPURISCVState *env)
> +{
> +#ifndef CONFIG_USER_ONLY
> +    CPUState *cs = env_cpu(env);
> +
> +    if (!riscv_cpu_cfg(env)->ext_sdext || env->debug_mode ||
> +        !(env->dcsr & DCSR_STEP)) {
> +        return;
> +    }
> +
> +    riscv_cpu_enter_debug_mode(env, env->pc, DCSR_CAUSE_STEP);
> +    cs->exception_index = EXCP_DEBUG;
> +    cpu_loop_exit_restore(cs, GETPC());
> +#endif
> +}
> +
>  void helper_sdext_ebreak(CPURISCVState *env, target_ulong pc)
>  {
>  #ifndef CONFIG_USER_ONLY
> @@ -604,6 +620,10 @@ void helper_wfi(CPURISCVState *env)
>                 (prv_u || (prv_s && get_field(env->hstatus, HSTATUS_VTW)))) {
>          riscv_raise_exception(env, RISCV_EXCP_VIRT_INSTRUCTION_FAULT, GETPC());
>      } else {
> +        if (riscv_cpu_cfg(env)->ext_sdext && !env->debug_mode &&
> +            (env->dcsr & DCSR_STEP)) {
> +            return;
> +        }
>          cs->halted = 1;
>          cs->exception_index = EXCP_HLT;
>          cpu_loop_exit(cs);
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 2b543ced07..0426855145 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -104,6 +104,7 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
>      RISCVCPU *cpu = env_archcpu(env);
>      RISCVExtStatus fs, vs;
>      uint32_t flags = 0;
> +    uint64_t ext_flags = 0;
>      bool pm_signext = riscv_cpu_virt_mem_enabled(env);
>  
>      if (cpu->cfg.ext_zve32x) {
> @@ -189,10 +190,16 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
>      flags = FIELD_DP32(flags, TB_FLAGS, PM_PMM, riscv_pm_get_pmm(env));
>      flags = FIELD_DP32(flags, TB_FLAGS, PM_SIGNEXTEND, pm_signext);
>  
> +#ifndef CONFIG_USER_ONLY
> +    if (cpu->cfg.ext_sdext && !env->debug_mode && (env->dcsr & DCSR_STEP)) {
> +        ext_flags = FIELD_DP64(ext_flags, EXT_TB_FLAGS, SDEXT_STEP, 1);
> +    }
> +#endif
> +
>      return (TCGTBCPUState){
>          .pc = env->xl == MXL_RV32 ? env->pc & UINT32_MAX : env->pc,
>          .flags = flags,
> -        .cs_base = env->misa_ext,
> +        .cs_base = ext_flags,
>      };
>  }
>  
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index e1f4dc5ffd..4660387164 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -110,6 +110,8 @@ typedef struct DisasContext {
>      bool ztso;
>      /* Use icount trigger for native debug */
>      bool itrigger;
> +    /* Enter Debug Mode after next instruction (sdext single-step). */
> +    bool sdext_step;
>      /* FRM is known to contain a valid value. */
>      bool frm_valid;
>      bool insn_start_updated;
> @@ -284,6 +286,9 @@ static void lookup_and_goto_ptr(DisasContext *ctx)
>      if (ctx->itrigger) {
>          gen_helper_itrigger_match(tcg_env);
>      }
> +    if (ctx->sdext_step) {
> +        gen_helper_sdext_step(tcg_env);
> +    }
>  #endif
>      tcg_gen_lookup_and_goto_ptr();
>  }
> @@ -294,6 +299,9 @@ static void exit_tb(DisasContext *ctx)
>      if (ctx->itrigger) {
>          gen_helper_itrigger_match(tcg_env);
>      }
> +    if (ctx->sdext_step) {
> +        gen_helper_sdext_step(tcg_env);
> +    }
>  #endif
>      tcg_gen_exit_tb(NULL, 0);
>  }
> @@ -307,7 +315,8 @@ static void gen_goto_tb(DisasContext *ctx, unsigned tb_slot_idx,
>        * Under itrigger, instruction executes one by one like singlestep,
>        * direct block chain benefits will be small.
>        */
> -    if (translator_use_goto_tb(&ctx->base, dest) && !ctx->itrigger) {
> +    if (translator_use_goto_tb(&ctx->base, dest) &&
> +        !ctx->itrigger && !ctx->sdext_step) {
>          /*
>           * For pcrel, the pc must always be up-to-date on entry to
>           * the linked TB, so that it can use simple additions for all
> @@ -1297,6 +1306,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
>      RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cs);
>      RISCVCPU *cpu = RISCV_CPU(cs);
>      uint32_t tb_flags = ctx->base.tb->flags;
> +    uint64_t ext_tb_flags = ctx->base.tb->cs_base;
>  
>      ctx->pc_save = ctx->base.pc_first;
>      ctx->priv = FIELD_EX32(tb_flags, TB_FLAGS, PRIV);
> @@ -1333,6 +1343,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
>      ctx->bcfi_enabled = FIELD_EX32(tb_flags, TB_FLAGS, BCFI_ENABLED);
>      ctx->fcfi_lp_expected = FIELD_EX32(tb_flags, TB_FLAGS, FCFI_LP_EXPECTED);
>      ctx->fcfi_enabled = FIELD_EX32(tb_flags, TB_FLAGS, FCFI_ENABLED);
> +    ctx->sdext_step = FIELD_EX64(ext_tb_flags, EXT_TB_FLAGS, SDEXT_STEP);
>      ctx->zero = tcg_constant_tl(0);
>      ctx->virt_inst_excp = false;
>      ctx->decoders = cpu->decoders;
> @@ -1383,7 +1394,8 @@ static void riscv_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
>  
>      /* Only the first insn within a TB is allowed to cross a page boundary. */
>      if (ctx->base.is_jmp == DISAS_NEXT) {
> -        if (ctx->itrigger || !translator_is_same_page(&ctx->base, ctx->base.pc_next)) {
> +        if (ctx->itrigger || ctx->sdext_step ||
> +            !translator_is_same_page(&ctx->base, ctx->base.pc_next)) {
>              ctx->base.is_jmp = DISAS_TOO_MANY;
>          } else {
>              unsigned page_ofs = ctx->base.pc_next & ~TARGET_PAGE_MASK;


