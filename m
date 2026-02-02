Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C923E7DF11
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 17:43:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmxxL-00026c-Fe; Mon, 02 Feb 2026 12:43:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vmxxJ-00024A-Nc
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 12:43:22 -0500
Received: from mail-qv1-xf42.google.com ([2607:f8b0:4864:20::f42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vmxxH-0005bF-5M
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 12:43:21 -0500
Received: by mail-qv1-xf42.google.com with SMTP id
 6a1803df08f44-894674a4c4aso85045546d6.3
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 09:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1770054198; x=1770658998; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/aI170ezDLKtlscnDkXKjbopbC62GikRHeSjoYSJg4U=;
 b=BsLy8EXkKCnetyvaWMssdAQD3tgycn/ZZeVntEskYlpL9bxttSJ/ScLKDOrEjsZPdE
 aPlVtFKt5J7UzfMiE26/YZlP8UIATTMWd5mjpS6JOaE9P55y8kxCFZNTfldJGlB2S9D2
 /6rxDKxgYStmbct5zJGKg6Lnrkom1OLlCSVSeHMjDsMiWCi4puSz0hvnpIwmOnfBghwp
 Ni+VsimwxrMQ6w4OA0DzDCWzYRK0Ku/AuFwajANDUApH2oboFgBiPRxnDvPPshJRAmo/
 BmrB7JOadBaaIkeUXq966juJcwXKmgexeNgW9xRU5yiDBhWAIbtk/zgSYg+jn/ziBz8i
 Lq2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770054198; x=1770658998;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/aI170ezDLKtlscnDkXKjbopbC62GikRHeSjoYSJg4U=;
 b=YLNzpW5T95Lmdwy526mFOD9KeYdTY7hvrDtFtv9AcI0pdM76MIcDiPhjqrMe/qm9xf
 VJ/efSZb5ias6c3PJQXB0fvm+SjyAr3cI6ynXry4nKIbErA2edmXtFqOw5MfrBHig2ku
 N2R/8G5RtwbX4xXmqf7so+9zcO2Am5EnMyGxxPq3mC0vILt6tVhWXRcDI0e64nT5NmOX
 PJQi1UKTgNY/E1JiBlKmPrDjw4sXQ3361tQ9/Oy2pCfv/TCTmwvca95HcCtWDW751c4u
 RLn4H3D5rcs1Ce22plfoLU51xGjiWEQ3mu61FB3tsXOntye4XfF5izSIO+k45lAkU3gn
 PN6w==
X-Gm-Message-State: AOJu0YznddqybJqC62FSd876BiZUXt93mTW7nGhq3yqU2cvE6ck3bcsv
 8wRAy+k8N0MLVOsX8M6Qh716+C8VsJme7jT15Ad31r6FxRcuZaKgtDvahkFHK12mPA0=
X-Gm-Gg: AZuq6aLyYq8Z+oxtvA1pivH9x/BOB7+Zq2GKGnzpo1uvLscoCNeCm5+apNBI9vlE89C
 THB5SFBtUK2ZUi33XC9b2d8yyVCMmK3bR/VFHnmyKK5lJS5s0A7HcFwmdvWDRNYUU7P1vOG2Og9
 Y3wXBJc90IWjE5wHQgT4pTxenKsDhX/wSFBX3cTVIeglOd+OcGs99dgCU8/g4tLeByDmeOhsieA
 L7REDvxoNUDsAeuFsC/CQqOtgiA2yU9eCO1PWYH3Wy7br20F+lvKKjXjjXLvOSVu761aX9XHn1Y
 3H9kH1AD/QsWpkb9x4QlCTG1s0OW0qEmDvhbYB8QuawIzuJsUhN3j2AQF07D6d7UUC5vBPp81m8
 Y6aCGkxpuXCAnlQKv1zbPSIx25ZKbnWLfMZdim7Pklvy6sPSHrgnvir2QFMmtimfeAzYcVeImXz
 IKQUA6nJFcsbDGthlI0Y5EuKHVatI75QdQCvBzWmB1s2raFiZo3ac5LydXdVOxOQ5LT8YXZwGTK
 Q==
X-Received: by 2002:a05:622a:103:b0:501:4b96:466d with SMTP id
 d75a77b69052e-505d226cd9fmr150990971cf.50.1770054198193; 
 Mon, 02 Feb 2026 09:43:18 -0800 (PST)
Received: from [192.168.68.103] (200-206-229-25.dsl.telesp.net.br.
 [200.206.229.25]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-894d36a9bdbsm115412566d6.11.2026.02.02.09.43.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Feb 2026 09:43:17 -0800 (PST)
Message-ID: <dc4bd280-a827-450c-adbe-659c1a20eb59@ventanamicro.com>
Date: Mon, 2 Feb 2026 14:43:14 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 6/7] target/riscv: add sdext single-step support
To: Chao Liu <chao.liu.zevorn@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 hust-os-kernel-patches@googlegroups.com, wangjingwei@iscas.ac.cn,
 devel@lists.libvirt.org
References: <cover.1769751489.git.chao.liu.zevorn@gmail.com>
 <4e1808a3ec0e99dcad9c8b5f4ef44ea5d5b00527.1769751489.git.chao.liu.zevorn@gmail.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <4e1808a3ec0e99dcad9c8b5f4ef44ea5d5b00527.1769751489.git.chao.liu.zevorn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f42;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-qv1-xf42.google.com
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



On 1/30/2026 3:00 AM, Chao Liu wrote:
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


Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   include/exec/translation-block.h |  4 ++--
>   target/riscv/cpu.h               |  2 ++
>   target/riscv/cpu_helper.c        |  6 ++++++
>   target/riscv/helper.h            |  1 +
>   target/riscv/op_helper.c         | 20 ++++++++++++++++++++
>   target/riscv/tcg/tcg-cpu.c       |  5 +++++
>   target/riscv/translate.c         | 16 ++++++++++++++--
>   7 files changed, 50 insertions(+), 4 deletions(-)
> 
> diff --git a/include/exec/translation-block.h b/include/exec/translation-block.h
> index 40cc699031..ee15608c89 100644
> --- a/include/exec/translation-block.h
> +++ b/include/exec/translation-block.h
> @@ -64,8 +64,8 @@ struct TranslationBlock {
>        * x86: the original user, the Code Segment virtual base,
>        * arm: an extension of tb->flags,
>        * s390x: instruction data for EXECUTE,
> -     * sparc: the next pc of the instruction queue (for delay slots).
> -     * riscv: an extension of tb->flags,
> +     * sparc: the next pc of the instruction queue (for delay slots),
> +     * riscv: an extension of tb->flags.
>        */
>       uint64_t cs_base;
>   
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 62732957a4..0d6b70c9f0 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -712,6 +712,8 @@ FIELD(TB_FLAGS, PM_SIGNEXTEND, 31, 1)
>   
>   FIELD(EXT_TB_FLAGS, MISA_EXT, 0, 32)
>   FIELD(EXT_TB_FLAGS, ALTFMT, 32, 1)
> +/* sdext single-step needs a TB flag to build 1-insn TBs */
> +FIELD(EXT_TB_FLAGS, SDEXT_STEP, 33, 1)
>   
>   #ifdef TARGET_RISCV32
>   #define riscv_cpu_mxl(env)  ((void)(env), MXL_RV32)
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 0e266ff3a9..a0874f4e23 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -635,6 +635,12 @@ bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
>       if (interrupt_request & mask) {
>           RISCVCPU *cpu = RISCV_CPU(cs);
>           CPURISCVState *env = &cpu->env;
> +
> +        if (cpu->cfg.ext_sdext && !env->debug_mode &&
> +            (env->dcsr & DCSR_STEP) && !(env->dcsr & DCSR_STEPIE)) {
> +            return false;
> +        }
> +
>           int interruptno = riscv_cpu_local_irq_pending(env);
>           if (interruptno >= 0) {
>               cs->exception_index = RISCV_EXCP_INT_FLAG | interruptno;
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index acff73051b..0b709c2b99 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -141,6 +141,7 @@ DEF_HELPER_1(tlb_flush_all, void, env)
>   DEF_HELPER_4(ctr_add_entry, void, env, tl, tl, tl)
>   /* Native Debug */
>   DEF_HELPER_1(itrigger_match, void, env)
> +DEF_HELPER_1(sdext_step, void, env)
>   DEF_HELPER_2(sdext_ebreak, void, env, tl)
>   #endif
>   
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index b6417b4b0b..e7878d7aa4 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -470,6 +470,22 @@ target_ulong helper_dret(CPURISCVState *env)
>   #endif
>   }
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
>   void helper_sdext_ebreak(CPURISCVState *env, target_ulong pc)
>   {
>       CPUState *cs = env_cpu(env);
> @@ -602,6 +618,10 @@ void helper_wfi(CPURISCVState *env)
>                  (prv_u || (prv_s && get_field(env->hstatus, HSTATUS_VTW)))) {
>           riscv_raise_exception(env, RISCV_EXCP_VIRT_INSTRUCTION_FAULT, GETPC());
>       } else {
> +        if (riscv_cpu_cfg(env)->ext_sdext && !env->debug_mode &&
> +            (env->dcsr & DCSR_STEP)) {
> +            return;
> +        }
>           cs->halted = 1;
>           cs->exception_index = EXCP_HLT;
>           cpu_loop_exit(cs);
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index f80e3413f8..53d862080c 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -193,6 +193,11 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
>       flags = FIELD_DP32(flags, TB_FLAGS, PM_SIGNEXTEND, pm_signext);
>   
>       ext_flags = FIELD_DP64(ext_flags, EXT_TB_FLAGS, MISA_EXT, env->misa_ext);
> +#ifndef CONFIG_USER_ONLY
> +    if (cpu->cfg.ext_sdext && !env->debug_mode && (env->dcsr & DCSR_STEP)) {
> +        ext_flags = FIELD_DP64(ext_flags, EXT_TB_FLAGS, SDEXT_STEP, 1);
> +    }
> +#endif
>   
>       return (TCGTBCPUState){
>           .pc = env->xl == MXL_RV32 ? env->pc & UINT32_MAX : env->pc,
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index f687c75fe4..c222b4bb06 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -110,6 +110,8 @@ typedef struct DisasContext {
>       bool ztso;
>       /* Use icount trigger for native debug */
>       bool itrigger;
> +    /* Enter Debug Mode after next instruction (sdext single-step). */
> +    bool sdext_step;
>       /* FRM is known to contain a valid value. */
>       bool frm_valid;
>       bool insn_start_updated;
> @@ -284,6 +286,9 @@ static void lookup_and_goto_ptr(DisasContext *ctx)
>       if (ctx->itrigger) {
>           gen_helper_itrigger_match(tcg_env);
>       }
> +    if (ctx->sdext_step) {
> +        gen_helper_sdext_step(tcg_env);
> +    }
>   #endif
>       tcg_gen_lookup_and_goto_ptr();
>   }
> @@ -294,6 +299,9 @@ static void exit_tb(DisasContext *ctx)
>       if (ctx->itrigger) {
>           gen_helper_itrigger_match(tcg_env);
>       }
> +    if (ctx->sdext_step) {
> +        gen_helper_sdext_step(tcg_env);
> +    }
>   #endif
>       tcg_gen_exit_tb(NULL, 0);
>   }
> @@ -307,7 +315,8 @@ static void gen_goto_tb(DisasContext *ctx, unsigned tb_slot_idx,
>         * Under itrigger, instruction executes one by one like singlestep,
>         * direct block chain benefits will be small.
>         */
> -    if (translator_use_goto_tb(&ctx->base, dest) && !ctx->itrigger) {
> +    if (translator_use_goto_tb(&ctx->base, dest) &&
> +        !ctx->itrigger && !ctx->sdext_step) {
>           /*
>            * For pcrel, the pc must always be up-to-date on entry to
>            * the linked TB, so that it can use simple additions for all
> @@ -1302,6 +1311,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
>       RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cs);
>       RISCVCPU *cpu = RISCV_CPU(cs);
>       uint32_t tb_flags = ctx->base.tb->flags;
> +    uint64_t ext_tb_flags = ctx->base.tb->cs_base;
>   
>       ctx->pc_save = ctx->base.pc_first;
>       ctx->priv = FIELD_EX32(tb_flags, TB_FLAGS, PRIV);
> @@ -1338,6 +1348,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
>       ctx->bcfi_enabled = FIELD_EX32(tb_flags, TB_FLAGS, BCFI_ENABLED);
>       ctx->fcfi_lp_expected = FIELD_EX32(tb_flags, TB_FLAGS, FCFI_LP_EXPECTED);
>       ctx->fcfi_enabled = FIELD_EX32(tb_flags, TB_FLAGS, FCFI_ENABLED);
> +    ctx->sdext_step = FIELD_EX64(ext_tb_flags, EXT_TB_FLAGS, SDEXT_STEP);
>       ctx->zero = tcg_constant_tl(0);
>       ctx->virt_inst_excp = false;
>       ctx->decoders = cpu->decoders;
> @@ -1388,7 +1399,8 @@ static void riscv_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
>   
>       /* Only the first insn within a TB is allowed to cross a page boundary. */
>       if (ctx->base.is_jmp == DISAS_NEXT) {
> -        if (ctx->itrigger || !translator_is_same_page(&ctx->base, ctx->base.pc_next)) {
> +        if (ctx->itrigger || ctx->sdext_step ||
> +            !translator_is_same_page(&ctx->base, ctx->base.pc_next)) {
>               ctx->base.is_jmp = DISAS_TOO_MANY;
>           } else {
>               unsigned page_ofs = ctx->base.pc_next & ~TARGET_PAGE_MASK;


