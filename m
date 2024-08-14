Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9351BC52D7B
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 01:45:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1se33M-0008NF-2W; Tue, 13 Aug 2024 21:43:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1se33K-0008Mm-Qx
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 21:43:54 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1se33I-0002sv-R1
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 21:43:54 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1fc4fccdd78so44475655ad.2
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 18:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723599831; x=1724204631; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SUP9wNJJyxSkEXFB2A61bgTzDre8nD7g52axkanqcP0=;
 b=Ezmbho/85JpCN7m+y1Qt9/oVqd0Yb8QAC3em3tTxtP4x/9h1EHweLQ9Qqw0hZiVk9x
 1V2Ois7UTZdPEgIWxjZxsrweE7AbuTwG10DdSwkQhFQT/4pxYJXv+ttpmES/I1NEXrZb
 /56II1U2WCyH9Ek+5zXgRHo83Nmq94/LajvKtEePMrxnsnKf1dPNpKxr5S1E5ENMG2b5
 y54mBfvEPeD7LgBKHbrYL67TOg8sAhEGsxjrj7g24S/etyWazWoJ5bluCu92MerhWZgj
 dfdbTiFs3i3ulf6pcsS5buuyTcpN218cxl9Yf89z8xeO30YYRxQTpZFnYc4G73uLhXgL
 I3BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723599831; x=1724204631;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SUP9wNJJyxSkEXFB2A61bgTzDre8nD7g52axkanqcP0=;
 b=cz1a24JTjYCvUk3BRWOQykRNEe2AycmW5y7RUobzy/ut9dkp3Nbj83wLUAhRvlbYOk
 96Xc5HnIDmDxm++r6BCid0Xa4w+OWC8OxeriBT49pq75ACw+ssbVM/2rSj5BhPvmf7Pl
 FfIv9fFh4rw0H+7j3+WwmKJIwHMljwL46ZwMmZ7j1zWwo42f3gNVJ28RH26b1NTeNA0h
 C06n4h262P5TiJodcxhTSWnYgygz5WTb337PYAsGJEd/SykNnEb8zdU9KXY2KX9Ydka3
 geZV8t0Q/Zy+Gfc/JrcmqPTPdD5pppGGxwpbsqea4AsyDsn+7U6OFHSJPco/Gg0nXluH
 nqbw==
X-Gm-Message-State: AOJu0YznCwPa2fsbWDc9fzbMrzd0xNYC3qKr4W8vWIaRc5V+GXcszXcD
 fJkpiTtxGf2qeUH2qil17gWZlWtddMOX9cKNuezZqd+tRzi4C0HHfBLZUj6xeTw=
X-Google-Smtp-Source: AGHT+IEguQmmRuqY+XlNpj2EZeIQw7c1z5urMUPMtuFCB0Co3UhZIzhfMdcNaWjrGNe0gnpVxVQ6qQ==
X-Received: by 2002:a17:902:ced0:b0:1fd:cda0:2f4c with SMTP id
 d9443c01a7336-201d63ad01bmr12363795ad.18.1723599830475; 
 Tue, 13 Aug 2024 18:43:50 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201cd1a9389sm19532435ad.135.2024.08.13.18.43.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Aug 2024 18:43:50 -0700 (PDT)
Message-ID: <db9a23a4-3423-4c55-8c6d-0507f93d3c50@linaro.org>
Date: Wed, 14 Aug 2024 11:43:42 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/sparc: emulate floating point queue when raising
 fp traps
To: Carl Hauser <chauser@pullman.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Cc: qemu-devel@nongnu.org, Carl Hauser <carl.hauser@gmail.com>
References: <cde53d38-c378-459f-9e2a-6e9ca287cc3c@pullman.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <cde53d38-c378-459f-9e2a-6e9ca287cc3c@pullman.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/14/24 09:22, Carl Hauser wrote:
> I am unable to test the linux and NetBSD behavior because I've been
> unable to get gcc to actually generate quad precision instructions on those
> systems.

-mhard-quad-float

> +
> +    /* single-element FPU fault queue */
> +    uint32_t fsr_qne;                /* qne */
> +    uint32_t fsr_qi;                 /* faulting fp instruction */
> +    target_ulong fsr_qa;             /* address of faulting instruction */

I suppose these could be sparc32 only, but not critical,
and it would require ifdefs elsewhere as well.

> diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
> index fbcb4f7aef..e0ad090340 100644
> --- a/target/sparc/insns.decode
> +++ b/target/sparc/insns.decode
> @@ -644,8 +644,9 @@ STF         11 ..... 100100 ..... . .............       @r_r_ri_na
>   STFSR       11 00000 100101 ..... . .............          @n_r_ri
>   STXFSR      11 00001 100101 ..... . .............          @n_r_ri
>   {
> -  STQF      11 ..... 100110 ..... . .............          @q_r_ri_na
> -  STDFQ     11 ----- 100110 ----- - -------------
> +
> +  STDFQ     11 ..... 100110 ..... . .............          @r_r_r_asi ## SPARC-V7-8
> +  STQF      11 ..... 100110 ..... . .............          @q_r_ri_na ## SPARC-V9
>   }

There is an existing bug:

- TRANS(STQF, ALL, do_st_fpr, a, MO_128)
+ TRANS(STQF, 64, do_st_fpr, a, MO_128)

which prevented the current ordering from working.  With the fix, just add the argument 
set for STDFQ (and the comments, I suppose).


> @@ -147,6 +148,20 @@ void sparc_cpu_do_interrupt(CPUState *cs)
>       env->psret = 0;
>       cwp = cpu_cwp_dec(env, env->cwp - 1);
>       cpu_set_cwp(env, cwp);
> +#ifndef TARGET_SPARC64
> +    if (intno == TT_FP_EXCP) {
> +        env->fsr_qne = FSR_QNE;
> +        env->fsr_qa = env->pc;
> +        env->fsr_qi = cpu_ldl_code(env, env->fsr_qa);
> +         /*
> +          * Because of the asynchronous FPU on real Sparc 32 bit
> +          * machines, the pc and npc will have already been advanced
> +          * by the time that the trap is taken.
> +          */
> +        env->pc = env->npc;
> +        env->npc = env->npc + 4;
> +    }
> +#endif

No need for the ifdef -- the whole file is sparc32 only.

> @@ -1458,8 +1459,10 @@ static void gen_op_fpexception_im(DisasContext *dc, int ftt)
>        * or when raising FSR_FTT_IEEE_EXCP, i.e. check_ieee_exception.
>        * Thus we can simply store FTT into this field.
>        */
> +
>       tcg_gen_st_i32(tcg_constant_i32(ftt), tcg_env,
>                      offsetof(CPUSPARCState, fsr_cexc_ftt));
> +
>       gen_exception(dc, TT_FP_EXCP);
>   }
> 

Drop the unrelated whitespace.

> -static bool trans_STDFQ(DisasContext *dc, arg_STDFQ *a)
> +static bool trans_STDFQ(DisasContext *dc, arg_r_r_ri_asi *a)
>   {
> +
> +#ifndef TARGET_SPARC64
>       if (!avail_32(dc)) {
>           return false;
>       }
> @@ -4538,10 +4543,19 @@ static bool trans_STDFQ(DisasContext *dc, arg_STDFQ *a)
>       if (gen_trap_ifnofpu(dc)) {
>           return true;
>       }
> -    gen_op_fpexception_im(dc, FSR_FTT_SEQ_ERROR);
> -    return true;
> +
> +    TCGv store_addr = gen_ldst_addr(dc, a->rs1, a->imm, a->rs2_or_imm);
> +    if (store_addr == NULL) {
> +        return false;
> +    }
> +    gen_helper_store_fp_queue(tcg_env, store_addr);
> +    return advance_pc(dc);
> +#else
> +    g_assert_not_reached();
> +#endif
>   }

You shouldn't need the ifdef here, because (1) avail_32 should make the whole function 
vanish for sparc64 and (2) you handled gen_helper_store_fp_queue with the 
qemu_build_not_reached define at the top of the file.

Otherwise, this looks really good.


r~

