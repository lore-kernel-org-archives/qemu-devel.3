Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C3AEDE9AB
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 18:34:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so5gP-0005FX-Po; Tue, 10 Sep 2024 14:33:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1so5g9-00058z-FN
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 14:33:37 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1so5g7-0001nv-9h
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 14:33:29 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-2705d31a35cso3286889fac.0
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 11:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725993205; x=1726598005; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HK5a2BELX1dytZ48ES+PmsyEIdWtSByFbfTvNLWvZIE=;
 b=j/lt1sKcEw4lv5JepPvSSF2HD36Y6ot+NgmQ+djgBJDzXGhAnJvavgDv1nLt1HDgkv
 +VRgdKP5KTscuWBZH/QZlj0FCcLMysB9TquMCOFtJYrx6THEmHOriVA116HYyFkAFMdb
 kGRqMvEdZFHx9MQFDbyAEzj+PxF6ERhLuMUgb03C+eOTpWIHKOzVWG+B/dOeqBWG3elt
 0y3d2UYAM/FmQV99o5YA8Ak6ngmyl4Rohatw3/NraanjDFhTBRNkEihTTqXjK7Vk0yNd
 dOyW1qSmnhG2dFKs5FxFUS3KaMuT7AGCvQNcASXBauokETvre2LqJYiFXIPA6nlNlRiP
 2Fxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725993205; x=1726598005;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HK5a2BELX1dytZ48ES+PmsyEIdWtSByFbfTvNLWvZIE=;
 b=KCAfh86HGZ6ZFGxsvPLLyRVJCOtNJ2UtuRNgZ4X3WbAcpsh6YfJxM6csbdox1CNtpD
 ERcDvGpqTIABp7JVtQvj9KOQGmsd8qa52Zsea8uDmVGqe+h+VHlTxHNivVF/Qi938mD7
 NfsmYcH6Dvpvoy64m0oSN1HWCgJ9whP+L4FyQ6h/cJLJ/cmFgwbw9C/b+CGeP7Dvmt2Y
 QTSbMp3Lv47//QBHaKhXOXHimWyC27IKzUba8NV2n1zbQSCzCYOJo/tEwrVQ/7xKiJKZ
 1tqoqUsEkOtVpRpq53SOT5F6jCywD1BwWb0rGYDMhrnd7TOvsyZwHSVaWaUDg75rKW76
 gFaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWubrsc6zLB+5ovIykdUiktcpNsxefPWbFHomxKF2hUM4TrRba1Ru48hhpsOx2I8I2L/Bm/5enJSuJi@nongnu.org
X-Gm-Message-State: AOJu0Yy1mDhhId4yBy8Kbmr/M91xilolawURsLk8ZIvtDO1bGVPzHTBv
 XmqOD5k3gClYgYu47PxvNaKMiBIMyzTzQ5wbhGbz90+OSneXbdXyFPnm8N4hHEQ=
X-Google-Smtp-Source: AGHT+IEbfdSpbH33p6dxavD22BVOGK68QosQoO4xLnTLbetVrdqvkHyyPpryU12eS5x3x8Q/ca4ieA==
X-Received: by 2002:a05:6871:60a:b0:270:46be:9534 with SMTP id
 586e51a60fabf-27b82ea94f1mr15489751fac.24.1725993204862; 
 Tue, 10 Sep 2024 11:33:24 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::9633? ([2604:3d08:9384:1d00::9633])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7d8255dc20fsm5057394a12.65.2024.09.10.11.33.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 11:33:24 -0700 (PDT)
Message-ID: <094e8d8a-331f-4bd7-a02e-d5bd722619b6@linaro.org>
Date: Tue, 10 Sep 2024 11:33:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/10] target/s390x: Enable CF_PCREL
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org
References: <20240605215739.4758-1-richard.henderson@linaro.org>
 <20240605215739.4758-11-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240605215739.4758-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-oa1-x35.google.com
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

On 6/5/24 14:57, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/s390x/cpu.c           | 17 +++++++++
>   target/s390x/tcg/translate.c | 71 +++++++++++++++++++++++-------------
>   2 files changed, 62 insertions(+), 26 deletions(-)
> 
> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index c786767bd1..9f03190c35 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -39,6 +39,7 @@
>   #include "sysemu/reset.h"
>   #endif
>   #include "hw/s390x/cpu-topology.h"
> +#include "exec/translation-block.h"
>   
>   #define CR0_RESET       0xE0UL
>   #define CR14_RESET      0xC2000000UL;
> @@ -111,6 +112,16 @@ uint64_t s390_cpu_get_psw_mask(CPUS390XState *env)
>       return r;
>   }
>   
> +static void s390_cpu_synchronize_from_tb(CPUState *cs,
> +                                         const TranslationBlock *tb)
> +{
> +    /* The program counter is always up to date with CF_PCREL. */
> +    if (!(tb_cflags(tb) & CF_PCREL)) {
> +        CPUS390XState *env = cpu_env(cs);
> +        env->psw.addr = tb->pc;
> +    }
> +}
> +
>   static void s390_cpu_set_pc(CPUState *cs, vaddr value)
>   {
>       S390CPU *cpu = S390_CPU(cs);
> @@ -246,6 +257,11 @@ static void s390_cpu_realizefn(DeviceState *dev, Error **errp)
>       S390CPUClass *scc = S390_CPU_GET_CLASS(dev);
>       Error *err = NULL;
>   
> +#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
> +    /* Use pc-relative instructions in system-mode */
> +    cs->tcg_cflags |= CF_PCREL;
> +#endif
> +
>       /* the model has to be realized before qemu_init_vcpu() due to kvm */
>       s390_realize_cpu_model(cs, &err);
>       if (err) {
> @@ -368,6 +384,7 @@ void cpu_get_tb_cpu_state(CPUS390XState *env, vaddr *pc,
>   
>   static const TCGCPUOps s390_tcg_ops = {
>       .initialize = s390x_translate_init,
> +    .synchronize_from_tb = s390_cpu_synchronize_from_tb,
>       .restore_state_to_opc = s390x_restore_state_to_opc,
>   
>   #ifdef CONFIG_USER_ONLY
> diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
> index 0ee14484d0..6961ad7c67 100644
> --- a/target/s390x/tcg/translate.c
> +++ b/target/s390x/tcg/translate.c
> @@ -139,6 +139,7 @@ struct DisasFields {
>   struct DisasContext {
>       DisasContextBase base;
>       const DisasInsn *insn;
> +    target_ulong pc_save;
>       DisasFields fields;
>       uint64_t ex_value;
>       uint32_t ilen;
> @@ -161,28 +162,6 @@ static uint64_t inline_branch_hit[CC_OP_MAX];
>   static uint64_t inline_branch_miss[CC_OP_MAX];
>   #endif
>   
> -static void gen_psw_addr_disp(DisasContext *s, TCGv_i64 dest, int64_t disp)
> -{
> -    tcg_gen_movi_i64(dest, s->base.pc_next + disp);
> -}
> -
> -static void pc_to_link_info(TCGv_i64 out, DisasContext *s)
> -{
> -    TCGv_i64 tmp;
> -
> -    if (s->base.tb->flags & FLAG_MASK_64) {
> -        gen_psw_addr_disp(s, out, s->ilen);
> -        return;
> -    }
> -
> -    tmp = tcg_temp_new_i64();
> -    gen_psw_addr_disp(s, tmp, s->ilen);
> -    if (s->base.tb->flags & FLAG_MASK_32) {
> -        tcg_gen_ori_i64(tmp, tmp, 0x80000000);
> -    }
> -    tcg_gen_deposit_i64(out, out, tmp, 0, 32);
> -}
> -
>   static TCGv_i64 psw_addr;
>   static TCGv_i64 psw_mask;
>   static TCGv_i64 gbea;
> @@ -338,6 +317,34 @@ static void store_freg32_i64(int reg, TCGv_i64 v)
>       tcg_gen_st32_i64(v, tcg_env, freg32_offset(reg));
>   }
>   
> +static void gen_psw_addr_disp(DisasContext *s, TCGv_i64 dest, int64_t disp)
> +{
> +    assert(s->pc_save != -1);
> +    if (tb_cflags(s->base.tb) & CF_PCREL) {
> +        disp += s->base.pc_next - s->pc_save;
> +        tcg_gen_addi_i64(dest, psw_addr, disp);
> +    } else {
> +        tcg_gen_movi_i64(dest, s->base.pc_next + disp);
> +    }
> +}
> +
> +static void pc_to_link_info(TCGv_i64 out, DisasContext *s)
> +{
> +    TCGv_i64 tmp;
> +
> +    if (s->base.tb->flags & FLAG_MASK_64) {
> +        gen_psw_addr_disp(s, out, s->ilen);
> +        return;
> +    }
> +
> +    tmp = tcg_temp_new_i64();
> +    gen_psw_addr_disp(s, tmp, s->ilen);
> +    if (s->base.tb->flags & FLAG_MASK_32) {
> +        tcg_gen_ori_i64(tmp, tmp, 0x80000000);
> +    }
> +    tcg_gen_deposit_i64(out, out, tmp, 0, 32);
> +}
> +
>   static void per_branch(DisasContext *s, TCGv_i64 dest)
>   {
>   #ifndef CONFIG_USER_ONLY
> @@ -1081,13 +1088,13 @@ static DisasJumpType help_goto_direct(DisasContext *s, int64_t disp)
>       if (disp == s->ilen) {
>           return DISAS_NEXT;
>       }
> +    gen_psw_addr_disp(s, psw_addr, disp);
>       if (use_goto_tb(s, dest)) {
>           tcg_gen_goto_tb(0);
> -        gen_psw_addr_disp(s, psw_addr, disp);
>           tcg_gen_exit_tb(s->base.tb, 0);
>           return DISAS_NORETURN;
>       } else {
> -        gen_psw_addr_disp(s, psw_addr, disp);
> +        s->pc_save = dest;
>           return DISAS_PC_CC_UPDATED;
>       }
>   }
> @@ -1097,6 +1104,7 @@ static DisasJumpType help_goto_indirect(DisasContext *s, TCGv_i64 dest)
>       update_cc_op(s);
>       per_breaking_event(s);
>       tcg_gen_mov_i64(psw_addr, dest);
> +    s->pc_save = -1;
>       per_branch(s, psw_addr);
>       return DISAS_PC_CC_UPDATED;
>   }
> @@ -1173,6 +1181,7 @@ static DisasJumpType help_branch(DisasContext *s, DisasCompare *c,
>           tcg_gen_exit_tb(s->base.tb, 1);
>           return DISAS_NORETURN;
>       }
> +    s->pc_save = s->base.pc_next + s->ilen;
>       return DISAS_PC_CC_UPDATED;
>   }
>   
> @@ -2351,6 +2360,7 @@ static DisasJumpType op_ex(DisasContext *s, DisasOps *o)
>       }
>   
>       gen_psw_addr_disp(s, psw_addr, 0);
> +    s->pc_save = s->base.pc_next;
>       update_cc_op(s);
>   
>       if (r1 == 0) {
> @@ -6411,6 +6421,7 @@ static void s390x_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
>   
>       /* Note cpu_get_tb_cpu_state asserts PC is masked for the mode. */
>   
> +    dc->pc_save = dc->base.pc_first;
>       dc->cc_op = CC_OP_DYNAMIC;
>       dc->ex_value = dc->base.tb->cs_base;
>       dc->exit_to_mainloop = dc->ex_value;
> @@ -6423,9 +6434,13 @@ static void s390x_tr_tb_start(DisasContextBase *db, CPUState *cs)
>   static void s390x_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
>   {
>       DisasContext *dc = container_of(dcbase, DisasContext, base);
> +    target_ulong pc_arg = dc->base.pc_next;
>   
> +    if (tb_cflags(dc->base.tb) & CF_PCREL) {
> +        pc_arg &= ~TARGET_PAGE_MASK;
> +    }
>       /* Delay the set of ilen until we've read the insn. */
> -    tcg_gen_insn_start(dc->base.pc_next, dc->cc_op, 0);
> +    tcg_gen_insn_start(pc_arg, dc->cc_op, 0);
>   }
>   
>   static target_ulong get_next_pc(CPUS390XState *env, DisasContext *s,
> @@ -6517,7 +6532,11 @@ void s390x_restore_state_to_opc(CPUState *cs,
>       CPUS390XState *env = cpu_env(cs);
>       int cc_op = data[1];
>   
> -    env->psw.addr = data[0];
> +    if (tb_cflags(tb) & CF_PCREL) {
> +        env->psw.addr = (env->psw.addr & TARGET_PAGE_MASK) | data[0];
> +    } else {
> +        env->psw.addr = data[0];
> +    }
>   
>       /* Update the CC opcode if it is not already up-to-date.  */
>       if ((cc_op != CC_OP_DYNAMIC) && (cc_op != CC_OP_STATIC)) {

I'm not an expert on s390x, but based on implementation of CF_PCREL for 
other arch, it seems correct.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

