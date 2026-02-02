Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D68CE7DF11
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 17:40:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmxuS-0007mK-JH; Mon, 02 Feb 2026 12:40:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vmxuQ-0007lB-0v
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 12:40:22 -0500
Received: from mail-qv1-xf41.google.com ([2607:f8b0:4864:20::f41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vmxuO-0004vF-9r
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 12:40:21 -0500
Received: by mail-qv1-xf41.google.com with SMTP id
 6a1803df08f44-88fca7bce90so60215406d6.3
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 09:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1770054019; x=1770658819; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0xkyWiEdDKNVVnO8ap23K+2zAH5imv4pNXBHek0iuZk=;
 b=HOlfeTyLL/RRz00jdhtf+nV2JdT3IXnV1un8aClxWf3rDtO4VMI2ptgPzKkX/OSBDZ
 zGzL2sZwjVmahyuNhc+vnpWPKzvCLeTDyw2lQDy+M/DQ/SmXmRL8MJqjFFVA0RKt70rV
 S5xRQxrSIgqgCZPTNLTz0/VLL2ps8kT+6pQIH86q50y4vyKW/yFsuWbl44hD32THO3W/
 JSbJs+qnJwFCSyrYClgnXV3pEjuHAheduAyFsBMKySPwps3fIO8xy38xscxUFj6fS1mQ
 3kXigjXupgGSwP6mA1HfH4+I7o+oPDe7MScv1BwjS8tU4zPp8YcdzPiMgf4nZJ9mNBou
 nEPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770054019; x=1770658819;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0xkyWiEdDKNVVnO8ap23K+2zAH5imv4pNXBHek0iuZk=;
 b=l6oDFJf/oPGDXaEO82vbdUanB528xq1jqy1Xe0XkHYqDda8VdHUMbarkWBPDHQfaWF
 Ao5yBvaMGATMV2yYwZBXG52N9sAUOXI656EZnFv7TG80Rikk6BOm+0o5WTzy7zDY8JvB
 R6YoBx9IFGXi681voLGa6UsPPJqrbKaqhCSMlPcViQGutSBEJ7TzszM6CHtpMVogqoXF
 jhJhXfBroBaw8n4JhaYPnIbk0jLFpNOjt/2cix01jvxWpXNBahdLISCC+k4VYHqSken5
 LoU8VCZ48u+IGqwy8XpOXkW6fYyRLdoNxB+KPCPjK6xvyc4PfCkDgJdGkEPP2TOP2t6a
 1QXQ==
X-Gm-Message-State: AOJu0Yz1TxSzrZjjdmt69Hc6QhrEIboohsBH6t2hmeusdTej0LDx1TD4
 M3oOoCsDNQntuAaYJ9hWy6JZHol7k9py8H15nOkYTUa4gxmhR/Ma7ism7gAjO28YlTC23TAuhuJ
 Jbdgb7CtDrg==
X-Gm-Gg: AZuq6aLS/joxuAibmFZOO8kMSbhf5GpbxH1GfT+Z6BUI/0kwc9x9UZ6KcpTzxIF6tLa
 MH5quXwXhApu+Rj9LnXrDhKPwHMs2rTfF1hiKuX9AfdMSmIbq0hyrqkI7CHDR/+Pu93DIsjB4ra
 ursI1mojNVxJAPXWn0xw0kLJg++xVPpahqkLSKwKrJ63H1MgXoR9Sr7PEfjKcATCOXZVdju6lwJ
 nw4s+slW2QmkgNAFwYD5QH1zFKrfp39D+893EUHVRJKeVdE08fFBQcrvdge5fgvaOE7F3rmMpMA
 NJ1BB7aZCazPQ8IODU4BKSX1CU3Ft9W+p5RiavzzvOnWh1PwlaTIlLj3L16byjXT9WciJyeFeKu
 Ceu7rzyKxv5VojiVkON6BK5X7L3xsAbtu9eg9lcpE/N/MQy1QazZQuib6tanjmPQ4Za2nYItTbw
 elQkNVUWiMlf1UoedRtkhhpiztCZq5SARXAd33nZuW9BMiDIF8ejUdFDkbt9m1UXMr98Scmrz8K
 Q==
X-Received: by 2002:ac8:588d:0:b0:4ee:17e9:999d with SMTP id
 d75a77b69052e-505d21aa382mr166366201cf.34.1770054019143; 
 Mon, 02 Feb 2026 09:40:19 -0800 (PST)
Received: from [192.168.68.103] (200-206-229-25.dsl.telesp.net.br.
 [200.206.229.25]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-894d36a9b5bsm120994396d6.5.2026.02.02.09.40.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Feb 2026 09:40:18 -0800 (PST)
Message-ID: <000d0622-60f4-47b4-9aa7-785b148e65ee@ventanamicro.com>
Date: Mon, 2 Feb 2026 14:40:15 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 4/7] target/riscv: add dret instruction
To: Chao Liu <chao.liu.zevorn@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 hust-os-kernel-patches@googlegroups.com, wangjingwei@iscas.ac.cn,
 devel@lists.libvirt.org
References: <cover.1769751489.git.chao.liu.zevorn@gmail.com>
 <e9303b71b70db0669acff4a0dc625285c8ee0a4d.1769751489.git.chao.liu.zevorn@gmail.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <e9303b71b70db0669acff4a0dc625285c8ee0a4d.1769751489.git.chao.liu.zevorn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f41;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-qv1-xf41.google.com
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
> Add DRET decode/translate and a helper to leave Debug Mode and return
> to dpc. Executing DRET outside Debug Mode raises illegal instruction.
> 
> Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/helper.h                          |  1 +
>   target/riscv/insn32.decode                     |  1 +
>   target/riscv/insn_trans/trans_privileged.c.inc | 18 ++++++++++++++++++
>   target/riscv/op_helper.c                       | 16 ++++++++++++++++
>   4 files changed, 36 insertions(+)
> 
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index b785456ee0..6140b6340d 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -131,6 +131,7 @@ DEF_HELPER_6(csrrw_i128, tl, env, int, tl, tl, tl, tl)
>   #ifndef CONFIG_USER_ONLY
>   DEF_HELPER_1(sret, tl, env)
>   DEF_HELPER_1(mret, tl, env)
> +DEF_HELPER_1(dret, tl, env)
>   DEF_HELPER_1(mnret, tl, env)
>   DEF_HELPER_1(ctr_clear, void, env)
>   DEF_HELPER_1(wfi, void, env)
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index 6e35c4b1e6..4db842d5d9 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -118,6 +118,7 @@ sctrclr     000100000100     00000 000 00000 1110011
>   uret        0000000    00010 00000 000 00000 1110011
>   sret        0001000    00010 00000 000 00000 1110011
>   mret        0011000    00010 00000 000 00000 1110011
> +dret        0111101    10010 00000 000 00000 1110011
>   wfi         0001000    00101 00000 000 00000 1110011
>   sfence_vma  0001001    ..... ..... 000 00000 1110011 @sfence_vma
>   
> diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/riscv/insn_trans/trans_privileged.c.inc
> index 8a62b4cfcd..f8641b1977 100644
> --- a/target/riscv/insn_trans/trans_privileged.c.inc
> +++ b/target/riscv/insn_trans/trans_privileged.c.inc
> @@ -125,6 +125,24 @@ static bool trans_mret(DisasContext *ctx, arg_mret *a)
>   #endif
>   }
>   
> +static bool trans_dret(DisasContext *ctx, arg_dret *a)
> +{
> +#ifndef CONFIG_USER_ONLY
> +    if (!ctx->cfg_ptr->ext_sdext) {
> +        return false;
> +    }
> +    decode_save_opc(ctx, 0);
> +    translator_io_start(&ctx->base);
> +    gen_update_pc(ctx, 0);
> +    gen_helper_dret(cpu_pc, tcg_env);
> +    exit_tb(ctx); /* no chaining */
> +    ctx->base.is_jmp = DISAS_NORETURN;
> +    return true;
> +#else
> +    return false;
> +#endif
> +}
> +
>   static bool trans_mnret(DisasContext *ctx, arg_mnret *a)
>   {
>   #ifndef CONFIG_USER_ONLY
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index 6ccc127c30..99736bbebb 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -454,6 +454,22 @@ target_ulong helper_mret(CPURISCVState *env)
>       return retpc;
>   }
>   
> +target_ulong helper_dret(CPURISCVState *env)
> +{
> +    uintptr_t ra = GETPC();
> +#ifdef CONFIG_USER_ONLY
> +    riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, ra);
> +    return 0;
> +#else
> +    if (!riscv_cpu_cfg(env)->ext_sdext || !env->debug_mode) {
> +        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, ra);
> +    }
> +    target_ulong retpc = env->dpc & get_xepc_mask(env);
> +    riscv_cpu_leave_debug_mode(env);
> +    return retpc;
> +#endif
> +}
> +
>   target_ulong helper_mnret(CPURISCVState *env)
>   {
>       target_ulong retpc = env->mnepc;


