Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE73E784BE
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 03:21:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1va3oL-0005o4-8B; Sun, 28 Dec 2025 22:20:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1va3oK-0005no-7J
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 22:20:44 -0500
Received: from mail-yx1-xb143.google.com ([2607:f8b0:4864:20::b143])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1va3oI-0005YF-QR
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 22:20:43 -0500
Received: by mail-yx1-xb143.google.com with SMTP id
 956f58d0204a3-6420c08f886so10602375d50.3
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 19:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766978441; x=1767583241; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TUHmjdL6hUEylXLs3Risv1+J/gwZKCuK/YHdhbG8668=;
 b=HwkB2sfXvyToFMwHVMoh/TjwYqpiHdEfQEorU/TuhaR311XsSl6dEtdDARVXM132hj
 oifVcq6VD97LrIVkdA3Iz6cJBr2ga4+157SLL26j1QW6graZ96wJibDIGt+r04CdDhq4
 IRJnm04MEmjFSCfCZEe7KSuP+kskoWHP+yygO4/qkyqg++fUIFtGAnJfyJo+PA5kA4PC
 ty+0p1ecqjMbKq/kgJw8CLKLmPXXQ1IZKd4wR80frUEU5lS2cx43geuHAz6xLISLEeEW
 V4qrWgl1a6zTndtxvA8nShjt5FFE9vd1Yt+KqlLSlX0LBOUHau85p7nnqm6mPV6CbrIT
 z+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766978441; x=1767583241;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TUHmjdL6hUEylXLs3Risv1+J/gwZKCuK/YHdhbG8668=;
 b=sD0KjiYQyJGUCiSea/dvvlDmsqJNa5/RXokYXh83uF2HMSXyirJWJ12LbVKQ2FYq8C
 Qtmn7KXIg8PhynzxkNb/6ixAft4VHA32ioZgr7Xj0BeQ+naCbd5+FBkTvmdmpq/kHmHL
 ef/LcT8SsqjW5RmUb4ymoW6846LAaD3rnIg2PrMCvqLq3itTAjN1x8k1d06eZB3WJHNc
 N4SOH33WLJCPNTm+NCW/eW1YzT2VkIpT4ocg3QUSWudrxqrpnuIysdt0hi5pLz+9uPD/
 OvE+qUF6boEzeJTrh0u7O5aeDCnILdpDSnIOpB96iCWYYfSXQrzqwiUh8zxda97rDmyN
 +SCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwr3ckDxq1YRiuUvUnwsyolcRXlqpTA3reT3PBJst7eA3Or30HyNT2ejRE9uld4vmHaY3pR4T1mXac@nongnu.org
X-Gm-Message-State: AOJu0Yz3RPT6Zv5yZziJnpABDgdZbna11oS/3aKY8T3wWEoCclJoahHv
 kDwX2sX4oQGbG9nxe/XboqCd38x2ps1xw8YDccQEn0CbTukh6acCLg/nk5UYp/Lvz4k=
X-Gm-Gg: AY/fxX67QDkSermKkKYTSozTjQBy/RUYVrlj6GLSiaOdXGGRZ0ikFaKYL5dEV+E6KoK
 EczkyUw3xjidUqH4iN0IA7AyGA1vMdhjkhluB6tGaDsEuD10BqBgX20AftUiQsTHKrpU4mNFLOR
 WnQSchC1XG8mHWNqn2TAMnctAgX4nAoK5Dvu9MAXTtApS6g0EC6MfzBtV4iCUvm/EtBFqaScvLw
 9k4ZzMjVJbp22WqJoKBthCvM9GSuBL4bI1UPHOohYlwz5gigme/k1ZZPBdleq4zVfjIJYV8UBl+
 DsaeiIh3h3H98cytpaTGqYU54lQHhnxUUVH/L9lbrxmPb7tUC8lpWx9g8r+L6NQ5kUCXL/dPqpm
 kgCUh6BshiG6KakKsIl4mMTPZ4U0ffexlq05wDqZMHqw7um9CyMWtzluSZ7C6nNnBsjqLzeV9JV
 5h3lP14OVQCWz8Zp76rC+8CB4KKQ==
X-Google-Smtp-Source: AGHT+IFF71sn5CdL5BnTVijSC4gj28mILAnX4GjHcEP7m861oEMy1oozqskHUCpcywF1bixQ5NsCiA==
X-Received: by 2002:a05:690e:250b:20b0:644:fc4b:6fa4 with SMTP id
 956f58d0204a3-6466a8c3a70mr17442680d50.68.1766978441427; 
 Sun, 28 Dec 2025 19:20:41 -0800 (PST)
Received: from [192.168.1.105] ([206.83.118.74])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-6466a8bd6ffsm14357945d50.9.2025.12.28.19.20.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Dec 2025 19:20:41 -0800 (PST)
Message-ID: <56160623-9f48-4e51-8cce-2addd00a42ac@linaro.org>
Date: Mon, 29 Dec 2025 14:19:06 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] target/alpha: Inline translator_ldl()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Anton Johansson <anjo@rev.ng>
References: <20251224160040.88612-1-philmd@linaro.org>
 <20251224160040.88612-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251224160040.88612-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b143;
 envelope-from=richard.henderson@linaro.org; helo=mail-yx1-xb143.google.com
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

On 12/25/25 03:00, Philippe Mathieu-Daudé wrote:
> translator_ldl() is defined in "exec/translator.h" as:
> 
>    198 static inline uint32_t
>    199 translator_ldl(CPUArchState *env, DisasContextBase *db, vaddr pc)
>    200 {
>    201     return translator_ldl_end(env, db, pc, MO_TE);
>    202 }
> 
> Directly use the inlined form, expanding MO_TE -> MO_LE
> since Alpha use little-endian order.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/alpha/translate.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/alpha/translate.c b/target/alpha/translate.c
> index b1d8a4eb80a..48ac50a7cdf 100644
> --- a/target/alpha/translate.c
> +++ b/target/alpha/translate.c
> @@ -2904,8 +2904,8 @@ static void alpha_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
>   static void alpha_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
>   {
>       DisasContext *ctx = container_of(dcbase, DisasContext, base);
> -    uint32_t insn = translator_ldl(cpu_env(cpu), &ctx->base,
> -                                   ctx->base.pc_next);
> +    uint32_t insn = translator_ldl_end(cpu_env(cpu), &ctx->base,
> +                                       ctx->base.pc_next, MO_LE);
>   
>       ctx->base.pc_next += 4;
>       ctx->base.is_jmp = translate_one(ctx, insn);

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

