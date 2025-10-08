Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59268CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 17:32:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6Y0t-0005Gt-Eq; Wed, 08 Oct 2025 13:31:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v6Y0r-0005GI-HP
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 13:31:41 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v6Y0l-0003Mu-3o
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 13:31:41 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-267facf9b58so418645ad.2
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 10:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759944691; x=1760549491; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s4Ymrfsnfpt7G6ml0GpxWhDM6qxT0MncV4vwb0axV64=;
 b=Q/NhPDCxNFazrQGpGmoBHfCFiw/CrOz4T7HlQbZSrTJURhaZGy3I0jKCb9b1OKRvEa
 aygXYEhOuPSoYiUPDrlPGrdtXDAyiNTtJvs0sdW1/uxp+lP71MgkZVj99bzVEn6eWpCX
 V2gDwn4cy0ACkpPy3AWFMAtTeWdOjhbPRn1q2XhKoFf3rexcbgUPd6xJ95oPQlkcVzOp
 QvdR3DHDRnIhXr7tepmM1jhe8u8b1Hq4JsmJ2zMuvNM3kpcNOgFaRay/CgYp8RV7HspX
 vGdJTDBEk2nUm01Qr7Atkm06tfVtBFno+b0+f+wRH85F611/JkhsMyaLzANa1lFscEqt
 BeNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759944691; x=1760549491;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s4Ymrfsnfpt7G6ml0GpxWhDM6qxT0MncV4vwb0axV64=;
 b=o9L42/mcvTvsTYHfGY6+8kvJevs/1gC+pMn3sC4QkwkoGsy7m6K7tLahnRhNLdZnaI
 941TSpn9fqHdTXEkGQyEhhHkoRqm1mYUDwXa4XD8v1q0Z/nj8WTi5wFtpNNDqI7eAU+w
 JIyBGu63GY+6Saxk/xN46KmnmfrPnSzJ17AHBc7RpOZTfmNrlcxDf8cMbwHwGUfcHWjp
 u2HlvEgSR1R/BBllPJjrd7svcZW2fbv4bJrJ/EAJrFXqbRmcBpGJ6wpNCFfRVeuoke6+
 nW9Qv4/EZnfcUSzTKorFH8Aa8fF5vqf8cxezQMkHrFuJTsfDYU8U/Gd0hb1HOAE15dhr
 zmFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8Yaq20fkN4a/gjUmcqZunwk5SP8mect1WwWuCbGXAysEmwH8ypvcyxxJIJorixnX6cQ3f+VucSB/I@nongnu.org
X-Gm-Message-State: AOJu0Yz4mOPZo3i6n7sTDj5ZmFlqjK30qAzbIjCfM7gb/P+0j27mesEy
 0j4NPl3OEijtVxboofvaraNYZ0buiXwGbSFktm6Pf50SGN4sDPZZY2K1mI54quavlYg=
X-Gm-Gg: ASbGncuCxYavSVNSslm0rHzILfiZTWaODqnksXKz5y4JF1dmocr8DHIv4DrjwgrNYa2
 VEXZd/jC3On/jxHzQweu/JmlL95v2Fj7Rm8m8enLVqX2zUszikJJWjsrUQ/g66KVZmZUW0v9SQq
 xR7Yhzpv88OU3f7ve1f7YDZeJY+ABoEA/aM8FIx5uHKCqxuUFg2kIVJj3wzO0NUvjrQyIoGDmj4
 Dc7WQnPiGnLrPkNb8sFzlXPa7lKn4vrSC3AlcJOnyRvN2ks5boHlWXlmyiTNnbJM08lGnSh+VaK
 5jL6g+0Gpqjxl4VpxdETitWLaHkket84vDkWfoa01QAZhHUSFDGcTkCb90CKiR1ffBtqn0dRraJ
 z8PMreoAOru4GbACltECE4qyh3p0JBPZoWoCipf/HtcejPtJCqluygCQ+tvlLHCw=
X-Google-Smtp-Source: AGHT+IE55kfcPrDsYN2DYDtuLFhzTcalzYHnyEbC6zHi6qcl0Cx++zKot358YgxiYJVWAN4xVeTUWA==
X-Received: by 2002:a17:903:1a8e:b0:24b:1625:5fa5 with SMTP id
 d9443c01a7336-29027356c0emr55399285ad.11.1759944691257; 
 Wed, 08 Oct 2025 10:31:31 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034e47341sm3100425ad.57.2025.10.08.10.31.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Oct 2025 10:31:30 -0700 (PDT)
Message-ID: <aba4a098-bfa4-45a5-914d-a200a6ca8a19@linaro.org>
Date: Wed, 8 Oct 2025 10:31:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] target/microblaze: Remove target_ulong use in
 helper_stackprot()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Alistair Francis <alistair@alistair23.me>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20251008060129.87579-1-philmd@linaro.org>
 <20251008060129.87579-5-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251008060129.87579-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

On 10/7/25 11:01 PM, Philippe Mathieu-Daudé wrote:
> Since commit 36a9529e60e ("target/microblaze: Simplify
> compute_ldst_addr_type{a,b}"), helper_stackprot() takes
> a TCGv_i32 argument.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/microblaze/helper.h    | 2 +-
>   target/microblaze/op_helper.c | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/target/microblaze/helper.h b/target/microblaze/helper.h
> index ef4fad9b91e..01eba592b26 100644
> --- a/target/microblaze/helper.h
> +++ b/target/microblaze/helper.h
> @@ -20,7 +20,7 @@ DEF_HELPER_FLAGS_3(fcmp_ne, TCG_CALL_NO_WG, i32, env, i32, i32)
>   DEF_HELPER_FLAGS_3(fcmp_ge, TCG_CALL_NO_WG, i32, env, i32, i32)
>   
>   DEF_HELPER_FLAGS_2(pcmpbf, TCG_CALL_NO_RWG_SE, i32, i32, i32)
> -DEF_HELPER_FLAGS_2(stackprot, TCG_CALL_NO_WG, void, env, tl)
> +DEF_HELPER_FLAGS_2(stackprot, TCG_CALL_NO_WG, void, env, i32)
>   DEF_HELPER_FLAGS_2(get, TCG_CALL_NO_RWG, i32, i32, i32)
>   DEF_HELPER_FLAGS_3(put, TCG_CALL_NO_RWG, void, i32, i32, i32)
>   
> diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
> index b8365b3b1d2..df93c4229d6 100644
> --- a/target/microblaze/op_helper.c
> +++ b/target/microblaze/op_helper.c
> @@ -365,13 +365,13 @@ uint32_t helper_pcmpbf(uint32_t a, uint32_t b)
>       return 0;
>   }
>   
> -void helper_stackprot(CPUMBState *env, target_ulong addr)
> +void helper_stackprot(CPUMBState *env, uint32_t addr)
>   {
>       if (addr < env->slr || addr > env->shr) {
>           CPUState *cs = env_cpu(env);
>   
>           qemu_log_mask(CPU_LOG_INT, "Stack protector violation at "
> -                      TARGET_FMT_lx " %x %x\n",
> +                                   "0x%x 0x%x 0x%x\n",
>                         addr, env->slr, env->shr);
>   
>           env->ear = addr;

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


