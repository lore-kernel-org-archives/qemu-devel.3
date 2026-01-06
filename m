Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C442CEFCEC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 19:01:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdCIp-0004gC-Ov; Tue, 06 Jan 2026 14:01:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdCIo-0004fq-Hx
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 14:01:10 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdCIl-0002pv-O8
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 14:01:10 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-bd1b0e2c1eeso929225a12.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jan 2026 11:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767726065; x=1768330865; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ReBAhb067gHricLSHUM9AeFeO0IToUY2tHejh7aJ52M=;
 b=ckRRkvEvldmG4RtEoyU94ldlrQUT4yQKx7lWQJ/1/0p90meVSc87Uz3ogkvh5zFm7P
 oM4bOolIpZelEkjpIg89w9/7rAByMiP1+2qVD2cZc3kYA6Ka2RUTA809rL9oARNrfFxE
 oLW1dhlR6/+dGpUuZ3pqJBGXUG9qR1jF2GDpDlQNzVAekmDIDO7qP4sR8UFd7iJRA8uK
 XOZszj82PMLUNClt4KXEpzfzCz2DTopcNo6Ujkm4u4F+T3xcgNe01T63hysU37oOE5p7
 JvnPPC2rwdCyu7aqSTiDTTkXtr+WfPm16Ueci6KC0VRD0NZTAJwhHGuw4pF46yUDeRbo
 afZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767726065; x=1768330865;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ReBAhb067gHricLSHUM9AeFeO0IToUY2tHejh7aJ52M=;
 b=rMrYdSfmOuRXSTZ/v2KfJaz6F9C7IK4oGB2jnCdAN/EvcZZihLY26f3lYa655UB9iz
 T6YKPgKyLFTwfS03iprI6MZyuRVa+pHHRbAiMXd+oqitaGQR5h8HJkcyY+IChd1yaYwB
 ckgAsytfx9LImJIFZJkDTwBU7kdQYq0sBowRKNDFbck1ewpbwrXzHb9iCMUA7bW+ju+1
 iTXZM/ZuGBMbY0Ek0KMNFtXt6Sqs0DZNV8P8PmHrDbcm3V30kQRuTXfohVMwAWa0gMFV
 Vi2cDAbjt+TAqgYqa2METPLSM8D37/m/u0dxjQpns6oD1tlscyY6xOfte3Fv+aYRRNyq
 snAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW825Uq8VBrX9lKK8zaEi4rurTJthAfnXKKOC5tBtVyoL8IVm7DKp8EeP8gX5pVlUS7KmMlTi8AaJ4s@nongnu.org
X-Gm-Message-State: AOJu0YwgaMgEDCBkZb2lehoritfgJCu85cZv6JvL9Av/t7kb93HGv8GU
 icRw+mbRkEcZ9IfiYSkWNRv8ehrvzQCTI5C+QRP676DFunbbSCchhr5qJaL7E05bEgdU3z35/0m
 /T0DeybY=
X-Gm-Gg: AY/fxX4UFf8AwwR85AkJgc2Q6Qz3SovG85yRHI+FjHr9Qtr3IX91ZOGIxwC3RWUEtzb
 sQMMCs2O2NQ/4eKeiE5LvYJqBfgXzA8+Z6qvKzkzRLCY4jDPC/PjVa+LuUkuG+HnAbVK/2yHbPd
 6Qra+iCBjEH3HayvqR30Kc8v2x8invSdsl5HQ12ppmj9fYZEmx7ziaSOmiG2MDoeLmd/pVDll1I
 fTufIuz0WWVEOnu83txfRIPJJ/JRIvlbQkf1KcMlA7xWCapLgQY3RuRcyaRk1wV7Sg6Z/XLw9BE
 kVr0cWw36Ub3ynsCGbWf86QR+zNEfAYTAzXwjb+7z1uWx//ySn2tY0jX+onlSxTzasf7kC9eboo
 ujO4DCqG4vqIv2gOkT/2DoBg0J/F2nBOkpryJxv2XNUm594tHE7DJrxZDVb/WFf+nGF9vsHKLoi
 CTGyodw20OlqM/pCSU7VV3MzdMWytf3w==
X-Google-Smtp-Source: AGHT+IGzIuw8oRdo4wAMSFCwLQFi+qGMC3aDqDf426eyvJZZAo+sTPOMmWFniqPbnumb5ZWQZ2CDTg==
X-Received: by 2002:a17:90b:1d82:b0:340:b86b:39c7 with SMTP id
 98e67ed59e1d1-34f68c92590mr125066a91.11.1767726065243; 
 Tue, 06 Jan 2026 11:01:05 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f6020926bsm1106250a91.10.2026.01.06.11.01.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jan 2026 11:01:04 -0800 (PST)
Message-ID: <f465bc94-4343-47f7-8526-3fb63eed54cd@linaro.org>
Date: Wed, 7 Jan 2026 06:00:58 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] target/alpha: Factor mo_endian() helper out
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Anton Johansson
 <anjo@rev.ng>, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260106155755.53646-1-philmd@linaro.org>
 <20260106155755.53646-6-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260106155755.53646-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

On 1/7/26 02:57, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/alpha/translate.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/target/alpha/translate.c b/target/alpha/translate.c
> index 3be97057465..4f918cbfe63 100644
> --- a/target/alpha/translate.c
> +++ b/target/alpha/translate.c
> @@ -96,6 +96,11 @@ static TCGv cpu_lock_value;
>   static TCGv cpu_pal_ir[31];
>   #endif
>   
> +static inline MemOp mo_endian(DisasContext *dc)
> +{
> +    return MO_TE;
> +}
> +
>   void alpha_translate_init(void)
>   {
>   #define DEF_VAR(V)  { &cpu_##V, #V, offsetof(CPUAlphaState, V) }
> @@ -2905,7 +2910,7 @@ static void alpha_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
>   {
>       DisasContext *ctx = container_of(dcbase, DisasContext, base);
>       uint32_t insn = translator_ldl_end(cpu_env(cpu), &ctx->base,
> -                                       ctx->base.pc_next, MO_TE);
> +                                       ctx->base.pc_next, mo_endian(ctx));
>   
>       ctx->base.pc_next += 4;
>       ctx->base.is_jmp = translate_one(ctx, insn);

I don't think we need this or the next.
The note about big-endian cray alpha was a mere curiosity.

r~

