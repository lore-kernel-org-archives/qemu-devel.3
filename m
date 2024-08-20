Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B712AC531DC
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 19:46:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgUnW-0008IY-7u; Tue, 20 Aug 2024 15:45:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sgUnU-0008HU-Qk
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 15:45:40 -0400
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sgUnS-0003W3-G8
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 15:45:40 -0400
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-5d608060241so3783143eaf.1
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2024 12:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724183136; x=1724787936;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N8irckvH/H6DKhID46AzYt7b/VlNCOwQ02I5aKGhwq8=;
 b=u040FgoV5kgz+wG4mfUFXLag4Y0CCF/F2875URcVv/2tVSQ3M7cBnw3lsD/FcamgJp
 0+DFJEIo3MX+lPrIArTWa6qDMA3cepbhpxNrZFiqmSNqPaXHiPMS2wEHnUZ/KexIVzW9
 uKxIHDi5mYyihW6HKxp6wChOJe2de5zqCArVojH9+6jawU6q/WhSI+vEMARPG4tolzng
 WbI6J5k+jM4+rjJntZ4RkzFD0I7/LPVfvdfvRFXWOatneSqvSK9DR4HZi5HrJzNIJC2l
 fGzFdLt1mHbXvN4paQ1sLkdzLSUw7E4JvtpAbH0hTtdfz7ni6S3WY+W+rtTkFLHv++WD
 33gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724183136; x=1724787936;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N8irckvH/H6DKhID46AzYt7b/VlNCOwQ02I5aKGhwq8=;
 b=HGenZb4EregSOoFVdmGg8CCDpVv9+T6AvbFUX63NTEBaWbutNCcJkkLB+8Z1LBSLcB
 suXpob+B0OMUJiGicDGVkImnr/mU3+hwtu1LRYQPTetC2eNhhbtwCP50/c5+MOyKw7FK
 gsqAJt2Y8E5LJmWJk7GmqhIO98Ps7jAnwlQu8uhYdrTmvLvhirRPlpiskOSkeL78Joxj
 AXBpyLwfssdaIjWpI74mYhWNx0wDMvv+eWvzsYLrUZsPTMkThcQLvFvGYXcao9guVPfq
 f2mD/E5s27ZJuMxLIHJojE1wiehuQgXmnzYaR68E8J/SO+b5+TOsMIAp6HpVKwm2nfOR
 nPbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpK6sVPc0dbNRnLPhkM8GceWhFHcE7Oo46xT7XqP4NpNYFtNtLtSWj9yerxNSrXR4qaNkFjh3TUCZD@nongnu.org
X-Gm-Message-State: AOJu0YyvPxBOzdXtNc2Ea+UgrGq0n7Gd30DkqE4PmKPX1VmyrXEFdZ4l
 jVVWAY40QihPMkqzGyPelXEjY2lpS0ce5EsQ2boPk9GyeiblFnqCM9xXMd3XIqFzkTNkNC5znM1
 bYoMtsNN1c6vhH+LHEYr7BMbrE2t4hOIM569/3Q==
X-Google-Smtp-Source: AGHT+IGL+n6D43bHF6uVtCsdlMyAYsDsd46HyxUyfsk6MyQqUhLjmxrFOX7n83hTbZvNBZT/ACW8X40+TMjkGlzDuUA=
X-Received: by 2002:a05:6358:5907:b0:1a6:7e01:e4f4 with SMTP id
 e5c5f4694b2df-1b59fc5edd1mr47732655d.28.1724183136379; Tue, 20 Aug 2024
 12:45:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240820000129.3522346-1-debug@rivosinc.com>
 <20240820000129.3522346-12-debug@rivosinc.com>
 <ZsRHPDG/GkyhdrQi@debug.ba.rivosinc.com>
 <c0afdd87-71c1-4b02-a2fb-5c9349205d8f@linaro.org>
 <ZsTmibCvaZJpEAPO@debug.ba.rivosinc.com>
In-Reply-To: <ZsTmibCvaZJpEAPO@debug.ba.rivosinc.com>
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 20 Aug 2024 12:45:24 -0700
Message-ID: <CAKC1njQT+hAeokOz-D++mogpLFUtKfX6x2KG4=yUfDBFdQS0WA@mail.gmail.com>
Subject: Re: [PATCH v5 11/15] target/riscv: mmu changes for zicfiss shadow
 stack protection
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 Alistair.Francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, 
 andy.chiu@sifive.com, kito.cheng@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=debug@rivosinc.com; helo=mail-oo1-xc34.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

On Tue, Aug 20, 2024 at 11:55=E2=80=AFAM Deepak Gupta <debug@rivosinc.com> =
wrote:
>
> On Tue, Aug 20, 2024 at 07:20:48PM +1000, Richard Henderson wrote:
> >On 8/20/24 17:35, Deepak Gupta wrote:
> >>>+    /* If shadow stack instruction initiated this access, treat it as=
 store */
> >>>+    if (mmu_idx & MMU_IDX_SS_WRITE) {
> >>>+        access_type =3D MMU_DATA_STORE;
> >>>+    }
> >>>+
> >>
> >>I think I forgot to address this. Do you still want me to fix this up l=
ike you
> >>had suggested?
> >
> >Yes, this still needs fixing.
> >
> >
> >>IIRC, you mentioned to use TARGET_INSN_START_EXTRA_WORDS=3D2. Honestly =
I don't know
> >>what it means and how its used. Based on git grep and some readup,
> >>are you expecting something
> >>along the below lines?
> >>
> >>
> >>"""
> >>
> >>diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> >>index fee31b8037..dfd2efa941 100644
> >>--- a/target/riscv/cpu.h
> >>+++ b/target/riscv/cpu.h
> >>@@ -47,7 +47,7 @@ typedef struct CPUArchState CPURISCVState;
> >>   * RISC-V-specific extra insn start words:
> >>   * 1: Original instruction opcode
> >>   */
> >>-#define TARGET_INSN_START_EXTRA_WORDS 1
> >>+#define TARGET_INSN_START_EXTRA_WORDS 2
> >>
> >>  #define RV(x) ((target_ulong)1 << (x - 'A'))
> >>
> >>diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> >>index f74a1216b1..b266177e46 100644
> >>--- a/target/riscv/cpu_helper.c
> >>+++ b/target/riscv/cpu_helper.c
> >>@@ -1271,6 +1271,11 @@ static void raise_mmu_exception(CPURISCVState
> >>*env, target_ulong address,
> >>  {
> >>      CPUState *cs =3D env_cpu(env);
> >>
> >>+     if (!pmp_violation &&
> >>+         tcg_ctx->gen_insn_data[TARGET_INSN_START_EXTRA_WORDS-1] & 1) =
{
> >>+         tcg_ctx->gen_insn_data[TARGET_INSN_START_EXTRA_WORDS-1] &=3D =
~1;
> >>+         access_type =3D MMU_DATA_STORE;
> >>+     }
> >
> >The first thing to understand is that the unwind data is stored by the
> >compiler and recovered by the unwinder.
> >
> >The unwind data is exposed to the target via one of two methods:
> >
> >(1) TCGCPUOps.restore_state_to_opc, i.e. riscv_restore_state_to_opc.
> >    The data[] argument contains the extra words.
> >
> >    With this method, the extra words are restored to env and are
> >    available in a later call to riscv_cpu_do_interrupt.
> >    Compare env->bins from the first extra word, which is used exactly s=
o.
> >
> >    This is probably the easiest and best option.
> >    You'd promote LOAD* to STORE_AMO* while dispatching the interrupt.
> >
> >(2) cpu_unwind_state_data()
> >
> >    With this method, you have immediate access to the extra words,
> >    and don't need to store them anywhere else.
> >
> >    This is supposed to be used when we are *not* going to raise
> >    an exception, merely look something up and continue execution.
> >    Otherwise, we'd be performing the unwind operation twice,
> >    and it's not cheap.
> >
> >So, tcg_ctx->gen_insn_data[] is not something you'd ever touch,
> >and this is the wrong spot to do anything.
>
> Thanks for more information and guiding me through this.
>
> Not going to say that I still understand everything. But I looked
> at one arm example. Before I do something more with it. I wanted to run
> it by you.
>
> Something on the below lines? I've one question as well for you in commen=
t.
>
> """"
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index fee31b8037..b4e04fe849 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -46,8 +46,14 @@ typedef struct CPUArchState CPURISCVState;
>   /*
>    * RISC-V-specific extra insn start words:
>    * 1: Original instruction opcode
> + * 2: more information about instruction
>    */
> -#define TARGET_INSN_START_EXTRA_WORDS 1
> +#define TARGET_INSN_START_EXTRA_WORDS 2
> +
> +/*
> + * b0: Whether a shadow stack operation/instruction or not.
> + */
> +#define RISCV_INSN_START_WORD2_SS_OP 1
>
>   #define RV(x) ((target_ulong)1 << (x - 'A'))
>
> @@ -226,6 +232,7 @@ struct CPUArchState {
>       bool      elp;
>       /* shadow stack register for zicfiss extension */
>       target_ulong ssp;
> +    bool      ss_op;
>       /* sw check code for sw check exception */
>       target_ulong sw_check_code;
>   #ifdef CONFIG_USER_ONLY
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index f74a1216b1..c28b13d42c 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -1777,6 +1777,10 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>       target_ulong mtval2 =3D 0;
>
>       if (!async) {
> +        /* shadow stack op, promote load page fault to store page fault =
*/
> +        if (env->ss_op && cause =3D=3D RISCV_EXCP_LOAD_PAGE_FAULT) {
> +            cause =3D RISCV_EXCP_STORE_PAGE_FAULT;
> +        }
>           /* set tval to badaddr for traps with address information */
>           switch (cause) {
>           case RISCV_EXCP_SEMIHOST:
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 4da26cb926..c0f21fe3db 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -129,6 +129,7 @@ static void riscv_restore_state_to_opc(CPUState *cs,
>           env->pc =3D pc;
>       }
>       env->bins =3D data[1];
> +    env->ss_op =3D data[2] & RISCV_INSN_START_WORD2_SS_OP;
>   }
>
>   static const TCGCPUOps riscv_tcg_ops =3D {
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 580aa23c5b..6f952db823 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -1271,7 +1271,7 @@ static void riscv_tr_insn_start(DisasContextBase *d=
cbase, CPUState *cpu)
>           pc_next &=3D ~TARGET_PAGE_MASK;
>       }
>
> -    tcg_gen_insn_start(pc_next, 0);
> +    tcg_gen_insn_start(pc_next, 0, 0);
>       ctx->insn_start_updated =3D false;
>   }
>
> @@ -1301,6 +1301,14 @@ static void riscv_tr_translate_insn(DisasContextBa=
se *dcbase, CPUState *cpu)
>           ctx->base.is_jmp =3D DISAS_NORETURN;
>       }
>
> +    /* shadow stack index means shadow stack instruction is translated *=
/
> +    if (ctx->mem_idx & MMU_IDX_SS_WRITE) {

This is a wrong check because we never store MMU_IDX_SS_WRITE in `ctx->mem_=
idx`
But I can place an indicator in `DisasContext` and set it up in
`trans_xxx` for shadow stack instr.

> +        /* Is this needed to set true? */
> +        ctx->insn_start_updated =3D true;
> +        tcg_set_insn_start_param(ctx->base.insn_start, 2,
> +                                 RISCV_INSN_START_WORD2_SS_OP);
> +    }
> +
>       /* Only the first insn within a TB is allowed to cross a page bound=
ary. */
>       if (ctx->base.is_jmp =3D=3D DISAS_NEXT) {
>           if (ctx->itrigger || !is_same_page(&ctx->base, ctx->base.pc_nex=
t)) {
>
> """
> >
> >
> >r~

