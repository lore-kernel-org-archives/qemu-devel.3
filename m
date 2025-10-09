Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C2ECCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 21:43:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6yPL-0001M1-6o; Thu, 09 Oct 2025 17:42:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6yPJ-0001Li-EP
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 17:42:41 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6yPH-0007yR-NF
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 17:42:41 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-33b5a3e8ae2so988326a91.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 14:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760046158; x=1760650958; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uDc4U1eaDJu6yW69qsTJL9WB54hCfHzEHqrQvRz06CE=;
 b=b91U8SIEzG8xF3A4p19L22tIPZpyBqJ82p+EfLgNIGZi+SpWvh7CY/4RyVhvOLUqWL
 qnq7ZvsTsU10HnCT9zbcSiOom2e2xcB1gKajuLLTVmg19vUojvurl9HklK3iGqKdl/e5
 Ju5hpJirOxOGX5Zt3ZhEVnIjFsv3/U3kp0hhT6Hx5I/jgc9rpAPYsV7mD+rGUthRcl1n
 WU94GYqQaRw1D0+WbJETpCz66KU1+Eg0OiJpIA8EfhF2DqODt5E83KEj9BBTRL7uMvA+
 1Mtin4Js5gyPbioG/ptadh569Nw6/gd8b5/T1CLB3hdvTgU9zLQ7Gi//gYzDHD+g7y4d
 weOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760046158; x=1760650958;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uDc4U1eaDJu6yW69qsTJL9WB54hCfHzEHqrQvRz06CE=;
 b=m56FxRCAxwcD+QxhpzvCYx3Sx1BtO3whAwejEY9yoWbk0y+vX3cT0Y77WHJz1n4GEC
 EN0Kv9mvDAjsfiT/Da7olG4MElmOIf/OsfwesUQ6yOxVpFAAlWBrfDHKCSQUBH5wRb8B
 NuePRFe4cux/s6IdDeHxKu4gNJjud4mUJTD5vVv0oyH9atINSBiMUgIUI6f1kmPDPIsB
 gXRvEu230WvEDwzM+J17YMT1Wa62lbKDTi5rh04smJDI5U8geXR/CgSwCIXzfZBhXYNg
 Qmc/tu1BjdwsVp8lGniHBxJhfjaHOFdKKnQZvVT8C7yqy/xa3x4b6GspV2Zqp5nXaunm
 lnXg==
X-Gm-Message-State: AOJu0Yz5Rjkvh03hUNG9udY9s2WHQ4OnfV0yS+PIYvWBgrEvn+2Knkuc
 dAKeisZ8+Sebpgg1B8SEXNv21/2THmW/Lc0BjH1M2xl/x8mG2EL7odMfx6y84hd62eqGIwUryh8
 gKWAEDWk=
X-Gm-Gg: ASbGncsNfhdUqX//CkC83zXWUNNRqmJbDVKDdJLbRMYXqSIlxk+yktSruxzgTxiLSLc
 pk1vdkt+yByY42QGeHGQBYekrM9csAiU3j1NACSgapmBjOj+gd1zlyEplpcHX7MlasFrywpLyVl
 7u5oKJQ6T7zKp97QchlGJ6RtYI5PCLnJP+Nb5UMbSi8SHXU4Td6VEzjEoL/vJug+J2FCX2tP9Mi
 gNQsMB946Opz0DjTNh57sTTVxEQiNHeOR2Wk8xI7Mrj2O74tbfFreFRyYOhujqv14jDlevr78pt
 TJD3Cnx5R/m67v4uHWwm1SEwcc8eYaGaHQ10qf32arXtOP9/61uRz3Ifzk6mfme6xnqHVbiommv
 v9Co/YScjZRqoV8spZ0/IcIaR/gZSMiKUNbQM6X2dldCUH60flKBT9RYs2aPDJ/GIwdepuFUoeK
 4=
X-Google-Smtp-Source: AGHT+IGitMI/dEVVJqq5pGSC1D9M9kIktceDKHDbizLLEqWNUM/11yyB0QG9lOQvpRpUj+vLWe2INg==
X-Received: by 2002:a17:90b:3b42:b0:32e:4716:d551 with SMTP id
 98e67ed59e1d1-33b516770a2mr11945729a91.6.1760046157853; 
 Thu, 09 Oct 2025 14:42:37 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33b6262df70sm570549a91.1.2025.10.09.14.42.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 14:42:37 -0700 (PDT)
Message-ID: <3460610b-5c1a-4189-8f0a-fd04897effb5@linaro.org>
Date: Thu, 9 Oct 2025 14:42:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/avr: Use vaddr type for $PC jumps
To: qemu-devel@nongnu.org
References: <20251009200525.33987-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251009200525.33987-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

On 10/9/25 13:05, Philippe Mathieu-Daudé wrote:
> translator_use_goto_tb() expects a vaddr type since commit
> b1c09220b4c ("accel/tcg: Replace target_ulong with vaddr in
> translator*()").
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/avr/translate.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/target/avr/translate.c b/target/avr/translate.c
> index 804b0b21dbd..20191055861 100644
> --- a/target/avr/translate.c
> +++ b/target/avr/translate.c
> @@ -87,7 +87,7 @@ struct DisasContext {
>       CPUAVRState *env;
>       CPUState *cs;
>   
> -    target_long npc;
> +    vaddr npc;

Ah, here's where proper typing might have saved us a bug.

npc is not a virtual (or physical) address in the normal sense, it is a *word* address 
(i.e. byte address / 2).

So I think you should just use uint32_t here.

>       uint32_t opcode;
>   
>       /* Routine used to access memory */
> @@ -981,7 +981,7 @@ static void gen_pop_ret(DisasContext *ctx, TCGv ret)
>       }
>   }
>   
> -static void gen_goto_tb(DisasContext *ctx, int n, target_ulong dest)
> +static void gen_goto_tb(DisasContext *ctx, int n, vaddr dest)
>   {
>       const TranslationBlock *tb = ctx->base.tb;
>   
> @@ -1004,7 +1004,7 @@ static void gen_goto_tb(DisasContext *ctx, int n, target_ulong dest)
>    */
>   static bool trans_RJMP(DisasContext *ctx, arg_RJMP *a)
>   {
> -    int dst = ctx->npc + a->imm;
> +    vaddr dst = ctx->npc + a->imm;

And here...

>   
>       gen_goto_tb(ctx, 0, dst);

... and therefore also in the gen_goto_tb argument.

The bug can thus be said to be within gen_goto_tb, where we don't convert from word 
address to byte address.



r~

