Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD2BC88E5C
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 00:59:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5v2M-0004YC-06; Sun, 13 Sep 2026 20:59:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5v2K-0004UD-BR
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 20:59:08 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5v2I-0005Hd-Da
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 20:59:08 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2d6d28aa26cso19856255ad.2
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 17:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789347544; x=1789952344; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=01V8qAHbRrbLD73qF6rxk6ZT+LflPQU2rePEqzW9TEk=;
 b=ni57L6aR/II5ijLMsPjPEdWxbz/Chu8a/D/Xub8iKLeKhmc60smQCCMEwVknKBKWkM
 bDHPu7NdP4GzO2hg4pGHJWjoKkF6nh+zxxaeqP3qO8NU5GKNxYOOQTTHOWcDJfmWUT7o
 BuMF/RfMr3qMD3wUFttedLH4qdCc8KP3c5Ss1xSVF9Bbsd607DzWLc7X8wQY+nvvZcXV
 wZwI6cyozs0frbvuOtGXeGZo+GA+72A2gx6dLMMyworvMEmAzSKHo7XEHYzZTYKv2ibs
 GFwcqIUcdithZpYzaKztW64ewXzeOIOhxyF4jbMe2UXiOxUndJF2Zgnro/UPn8kgAB1r
 UUGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789347544; x=1789952344;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=01V8qAHbRrbLD73qF6rxk6ZT+LflPQU2rePEqzW9TEk=;
 b=Sp6y9UnlTS8lwxAu/j+my1WV5y1x2ar9oIktXcNGsTaV2dg/cF3WOYQe4Ar37l8P1m
 Ylra3q0Y8Hx0hf+ZMeHm8yn7Fimcw3brTY8zKvC7o4LKQxGmRqvRWCueiDAky/JnK+gN
 J+EFJHEnXU/38bdzseRyia0WrTrXmjMxM5I/ijouGWC3Qlky0u9uE1iA3DqSK/F5vxoB
 9/fFanSfKvgQknbVK3CTzYUSLy115TdIKM7iJXrgFzvYe46/8aDk5juZBsh27Qki/Tyb
 5rMXUDQm6KwTImQLuL7/b4TzmN2vzy9kX6/5aSL3M/1JzW2JaDF4YV8UqBb97+8PxfKm
 bBrg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzMzXA5sZwfislfNBQAnwYNTkScKfS6HiMjEJL5nJh+EtvC8xiIOIWV13rMtob2RMPs+BRmhECPT2uN@nongnu.org
X-Gm-Message-State: AFuF++kidqJ4tlkyHa3kCaU552e+JLE2Ev/clZLE/pMqn/fD8Jv3+fyd
 bg/E6mHECs3PjA5C4jjWdi7uks4xwH4yV1HE2puQ5ez7jqMVeiKzWnk7RdTnvVD1bsU=
X-Gm-Gg: AYBFou0+zP3ec7AjGHGBAiERIp8Hg0fBkSmHWnDmECuJJunmXP67mLvGsnPxHRaFL2n
 ZBJYLLzqvUMvnSpcqVocKEgA6I01U50UCU4kiGY2C2JTuHCZrUAjvZQ+YCLu5m7oWhJ44QvXLsG
 MabJoNYYOw6linLpQ9IjRFT7hNRFwMpLUe6heSacZ6R5DPIg14tMv2TO/ImJlpiPwG2649jFFvp
 G8RWDg05gDyWqAWCsL7o0Zudc+iwZL/f9enoAa0gAm/mPysYiMARwt17JRaVJl6AdcHGPCwFMvV
 0/Wk53bGmSp7rINdHR40sNJdwOyxI+2fsdEMLc7O4Ts0nrBbEoGJGx7Fk09ESSbkYj0As+Ig08a
 hnResqncuOUwtszB/g77ert4baGCq7UnyGmYZTmrSkXprGwViTmm2m7bhc6FJPlAe99MJhUZEH5
 BahLpQLplOFrvifuT0TOZAS3BdyLUmdKiuP5BuLmBfwAILiDreS5zYquLhCWdd8S5FzpgQtlqJa
 Ws40LpqPdpDvJ6ZUX3y2pvLx8JsYl+Q48wKfpKPEW7YVbTHZOb11xOMbOL+Sw==
X-Received: by 2002:a17:902:d591:b0:2d7:5ebe:a588 with SMTP id
 d9443c01a7336-2dd6c6da391mr7219595ad.13.1789347544495; 
 Sun, 13 Sep 2026 17:59:04 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:1665:91c0:9a80:f870?
 ([2603:800c:7900:ed00:1665:91c0:9a80:f870])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4cf015csm24984449eec.4.2026.09.13.17.59.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Sep 2026 17:59:03 -0700 (PDT)
Message-ID: <1781cb62-97c0-4ff8-bd76-02e149030359@linaro.org>
Date: Sun, 13 Sep 2026 14:59:00 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] target/riscv: extract check_sfence_vma() from
 helper_tlb_flush()
To: Trevor Gamblin <tgamblin@baylibre.com>, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org
References: <20260904-riscv_tlb_page_flush-v2-0-defec3f29312@baylibre.com>
 <20260904-riscv_tlb_page_flush-v2-1-defec3f29312@baylibre.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260904-riscv_tlb_page_flush-v2-1-defec3f29312@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 9/4/26 08:43, Trevor Gamblin wrote:
> Create a new function to encapsulate the privilege/hypervisor checks
> performed inside helper_tlb_flush(). The idea is to pass GETPC() as an
> argument directly to it inside the helper_tlb_flush() function. We'll
> use this function in the following patch for helper_tlb_flush_page().
> 
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> ---
>   target/riscv/tcg/op_helper.c | 16 ++++++++++------
>   1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/target/riscv/tcg/op_helper.c b/target/riscv/tcg/op_helper.c
> index 3e94005d2b..7f63f3ada5 100644
> --- a/target/riscv/tcg/op_helper.c
> +++ b/target/riscv/tcg/op_helper.c
> @@ -588,21 +588,25 @@ void helper_wrs_nto(CPURISCVState *env)
>       }
>   }
>   
> -void helper_tlb_flush(CPURISCVState *env)
> +static void check_sfence_vma(CPURISCVState *env, uintptr_t ra)
>   {
> -    CPUState *cs = env_cpu(env);
>       if (!env->virt_enabled &&
>           (env->priv == PRV_U ||
>            (env->priv == PRV_S && get_field(env->mstatus, MSTATUS_TVM)))) {
> -        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
> +        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, ra);
>       } else if (env->virt_enabled &&
>                  (env->priv == PRV_U || get_field(env->hstatus, HSTATUS_VTVM))) {
> -        riscv_raise_exception(env, RISCV_EXCP_VIRT_INSTRUCTION_FAULT, GETPC());
> -    } else {
> -        tlb_flush(cs);
> +        riscv_raise_exception(env, RISCV_EXCP_VIRT_INSTRUCTION_FAULT, ra);
>       }
>   }

The priv and virt_enabled tests can be done in the translator.
Honestly, I'm surprised that PRV_U isn't already tested there.

PRV_M, could avoid the test.
PRV_S could perform the TVM test at runtime.

     ctx->virt_inst_excp = ctx->virt_enabled;
     if (ctx->priv == PRV_U) {
         gen_exception_illegal(ctx);
     } else if (ctx->priv == PRV_S) {
         TCGv_i64 t = tcg_temp_new_i64();
         TCGLabel *l = gen_new_label();
         uint64_t mask;
         ptrdiff_t ofs;

         if (ctx->virt_enabled) {
             ofs = offsetof(CPUArchState, hstatus);
             mask = HSTATUS_VTVM;
         } else {
             ofs = offsetof(CPUArchState, mstatus);
             mask = MSTATUS_TVM;
         }

         tcg_gen_ld_i64(t, tcg_env, ofs);
         gen_update_pc(ctx, 0);
         tcg_gen_brcondi_i64(TCG_COND_TSTEQ, t, mask, l);

         gen_exception_illegal(ctx);
         gen_set_label(l);
     }

Although the subtlety of virt_inst_excp vs virt_enabled wrt which 
exception is raised confuses me.

It appears this criticism is true for all privileged instructions, so 
perhaps this should be done as part of a more global cleanup.


r~

