Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CAF8E7DF11
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 17:43:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmxwm-0001IZ-Cy; Mon, 02 Feb 2026 12:42:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vmxwj-0001G9-EP
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 12:42:45 -0500
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vmxwh-0005Qu-Ep
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 12:42:45 -0500
Received: by mail-qk1-x741.google.com with SMTP id
 af79cd13be357-8c710439535so380696185a.1
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 09:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1770054162; x=1770658962; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nmbJnU/umBk6a+eACe5jmRu8A1rWAaTd3asImXe7Fdc=;
 b=QFp8yJGTG2zxXBGjl+dx0XqFF2RJFQyoQFWrz9CI0OK7MpwYrSWjIHsCs1hQLeFjLH
 d7xEldZZw2s52Q5EVnHg8JngwVaMJBM637EITojng4H3gCV++MrjzCvjOkkJJO1G0VRl
 fmQxyUzdig0n7toc8CK2It41numSpQpZ5ehUaQB0V9E+3ju9K1+JVOKUksraeJifaesH
 3dnKAh8F6OoNE4hcW3o6V1uilYGmt+c0HPpHATL5AlDiKlu+1XRuPrq0AYWb4fR01lU6
 DE+0sE9e5QHrBkmbHSxauk8DFDaKMKPntza767yBxNSX/k1idTOSXB8x1gW4yZFo505D
 2SAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770054162; x=1770658962;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nmbJnU/umBk6a+eACe5jmRu8A1rWAaTd3asImXe7Fdc=;
 b=MmNhoD2oQf4gSILtmzqqsN+7MpehAppMNTJ86QJ7+L+cED5oNuyoEw5ZhuYJ7yfE0e
 8wCqluOv6ToyfflomociD6PJvDG3jJ6V/IePBujDBVQuOOy/lKTi3n/NstfZfJcTElw5
 fyhKtQchKPyG9KyPLgr/zW4mBkYGfr6fAeilshuCqm2/hnYVTyf4qx+k5BaI40dDtudC
 ZP5FzSXkTSZIYjgcmauPYs/VskTT3n6pyIvmpNpglm7FroWXulF3a7cNHtXlh7ZqrBta
 HTWwQYTlZ1GX0wtyYqHZ1tNcZqJdG8K3HdA17zDZZoqedprU5DGgL+O9txzWa3p8SGb2
 QfPg==
X-Gm-Message-State: AOJu0YyEv2XVEdnDhm5snJ1U8Z/Rnckg/l8V6LdIYMEqIYty0B+tjEtc
 NtkOW5OVR9KpnZ0GN5mKs1au5eaQz+1+GC4voS1hL/vRfvhvo8qePyO8XpxI6RT5JBU=
X-Gm-Gg: AZuq6aL1TYESlnv2AsEVx9N3IgBL4Ik/tz/s73FCLL2kNm7B+qvGe6dN2VLpV04sDM6
 i/vZSqkFJ5R82/eNei+MQqfx5H2x8PCkTsBN7mx0YZiZ0J7VjiBPHy6wUnQgTCsH1dE8CnxpbpB
 A18qQAUJEtn7tjnfbJxUV6cN9Qtp2GoXHXslN8t3ipz1fFbIB+vaZLea0KmyCFV7AEd2/s21WAb
 agHFPETGMseU4PVr9L7W/ncQe9HsN8/Gims/mizIgttt0yC1tfRgzCYqM9wzKyHEc9n44A9rUr8
 2VGbFfqsndzt37WmxhspJI6FBnqSVmD4u1jiXkCGKGmHK1XDjed8ly1r/9oKmoJmwiMhbrIDEfq
 BbeHgpqz1COTcdlYbMpCnyyQa5A3mcgP0t6Sd/YPkw0mDro4Q5nc0DxtJVS4yviNlZnAFrWMlZz
 BmSWos5Yl16ahE5zREpvDTQXrRsUk41EELH/nBOl+VWzcHcR8cG+AY0Fz58vxBEzxbnfSfTUmtK
 A==
X-Received: by 2002:a05:620a:690d:b0:8c9:ea4f:b402 with SMTP id
 af79cd13be357-8c9eb2faf8dmr1516758485a.50.1770054161772; 
 Mon, 02 Feb 2026 09:42:41 -0800 (PST)
Received: from [192.168.68.103] (200-206-229-25.dsl.telesp.net.br.
 [200.206.229.25]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-894d375b62asm124136196d6.41.2026.02.02.09.42.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Feb 2026 09:42:41 -0800 (PST)
Message-ID: <78d5bb4d-f937-44c4-a303-00bbe468c208@ventanamicro.com>
Date: Mon, 2 Feb 2026 14:42:38 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 5/7] target/riscv: add sdext enter Debug Mode on
 ebreak
To: Chao Liu <chao.liu.zevorn@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 hust-os-kernel-patches@googlegroups.com, wangjingwei@iscas.ac.cn,
 devel@lists.libvirt.org
References: <cover.1769751489.git.chao.liu.zevorn@gmail.com>
 <92dad2c97a34c3d691919253a162ed5be5406e09.1769751489.git.chao.liu.zevorn@gmail.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <92dad2c97a34c3d691919253a162ed5be5406e09.1769751489.git.chao.liu.zevorn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::741;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-qk1-x741.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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



On 1/30/2026 3:00 AM, Chao Liu wrote:
> RISC-V Debug Specification:
> https://github.com/riscv/riscv-debug-spec/releases/tag/1.0
> 
> Route EBREAK via helper_sdext_ebreak. If Sdext is enabled and the
> matching dcsr.ebreak* bit is set, enter Debug Mode with cause=ebreak
> and stop with EXCP_DEBUG. Otherwise keep the normal breakpoint trap.
> 
> Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>


>   target/riscv/helper.h                         |  1 +
>   .../riscv/insn_trans/trans_privileged.c.inc   |  6 ++++
>   target/riscv/op_helper.c                      | 34 +++++++++++++++++++
>   3 files changed, 41 insertions(+)
> 
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index 6140b6340d..acff73051b 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -141,6 +141,7 @@ DEF_HELPER_1(tlb_flush_all, void, env)
>   DEF_HELPER_4(ctr_add_entry, void, env, tl, tl, tl)
>   /* Native Debug */
>   DEF_HELPER_1(itrigger_match, void, env)
> +DEF_HELPER_2(sdext_ebreak, void, env, tl)
>   #endif
>   
>   /* Hypervisor functions */
> diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/riscv/insn_trans/trans_privileged.c.inc
> index f8641b1977..84f0c77513 100644
> --- a/target/riscv/insn_trans/trans_privileged.c.inc
> +++ b/target/riscv/insn_trans/trans_privileged.c.inc
> @@ -68,9 +68,15 @@ static bool trans_ebreak(DisasContext *ctx, arg_ebreak *a)
>       if (pre == 0x01f01013 && ebreak == 0x00100073 && post == 0x40705013) {
>           generate_exception(ctx, RISCV_EXCP_SEMIHOST);
>       } else {
> +#ifndef CONFIG_USER_ONLY
> +        gen_update_pc(ctx, 0);
> +        gen_helper_sdext_ebreak(tcg_env, tcg_constant_tl(ebreak_addr));
> +        ctx->base.is_jmp = DISAS_NORETURN;
> +#else
>           tcg_gen_st_tl(tcg_constant_tl(ebreak_addr), tcg_env,
>                         offsetof(CPURISCVState, badaddr));
>           generate_exception(ctx, RISCV_EXCP_BREAKPOINT);
> +#endif
>       }
>       return true;
>   }
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index 99736bbebb..b6417b4b0b 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -470,6 +470,40 @@ target_ulong helper_dret(CPURISCVState *env)
>   #endif
>   }
>   
> +void helper_sdext_ebreak(CPURISCVState *env, target_ulong pc)
> +{
> +    CPUState *cs = env_cpu(env);
> +    bool enter_debug = false;
> +
> +    if (riscv_cpu_cfg(env)->ext_sdext && !env->debug_mode) {
> +        if (env->virt_enabled) {
> +            if (env->priv == PRV_S) {
> +                enter_debug = env->dcsr & DCSR_EBREAKVS;
> +            } else if (env->priv == PRV_U) {
> +                enter_debug = env->dcsr & DCSR_EBREAKVU;
> +            }
> +        } else {
> +            if (env->priv == PRV_M) {
> +                enter_debug = env->dcsr & DCSR_EBREAKM;
> +            } else if (env->priv == PRV_S) {
> +                enter_debug = env->dcsr & DCSR_EBREAKS;
> +            } else if (env->priv == PRV_U) {
> +                enter_debug = env->dcsr & DCSR_EBREAKU;
> +            }
> +        }
> +    }
> +
> +    env->badaddr = pc;
> +
> +    if (enter_debug) {
> +        riscv_cpu_enter_debug_mode(env, pc, DCSR_CAUSE_EBREAK);
> +        cs->exception_index = EXCP_DEBUG;
> +        cpu_loop_exit_restore(cs, GETPC());
> +    }
> +
> +    riscv_raise_exception(env, RISCV_EXCP_BREAKPOINT, GETPC());
> +}
> +
>   target_ulong helper_mnret(CPURISCVState *env)
>   {
>       target_ulong retpc = env->mnepc;


