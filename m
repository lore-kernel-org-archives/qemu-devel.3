Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A3CECAC5AE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 18:00:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1TmG-0004C8-SV; Wed, 24 Sep 2025 13:59:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Tlo-000458-Ft
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 13:59:16 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Tlf-0006Wf-K1
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 13:59:12 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-269639879c3so652515ad.2
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 10:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758736738; x=1759341538; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uVz6FvHlIasvKbbV85A6OijDq4t/e/y1CMkW3I8kXxY=;
 b=qVAa/QzzM05yS0vlxkWYyQmsh63gbLOTGd9UlABHF8xc3QFHtmcYDd/UaeHVv4fAwG
 PiwEWO0/g9gmNXqFlFzOol8LrHNnoOuOIk/KEJD4QHxOneruurECF6BZV3IM+EEZDQlM
 gJel4UrtheFQDUiz4esW/DqTo5LnV7xLohVoeNpMlEu4mj6xCH0RuGbu4mE0sgQdS9sG
 qdqz0rVSUK9hKWqzXdDJi815g88IW6jF0Wfywg8929zDoDskKq4lYUitdVTThSt3muk6
 y8//ERG3JdUDMikN5SAgbwPMo1708owiJHDQd4bZYMkU+ZFnFseU7Z5HjZU/NKUWfwiA
 GFww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758736738; x=1759341538;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uVz6FvHlIasvKbbV85A6OijDq4t/e/y1CMkW3I8kXxY=;
 b=UsLrxFFUfUfacKcmmZIQivdIl/lX0ce3WNeGTmLKXVL/8uBZ6qffaRnITfa8ppKars
 d1yj5iR0gvF0+OWKg7MVUzaV5hyV1ZfvFLWE4JvnTDT/YDOMpeXQ2UR0o5dRo959DbYt
 4BdBLSNQLG+An8liTVh6a/F3yKNzN4lFL/gazhRknNfWHVIjrXkSyS8bCjH3O0UJsvU4
 PT5LybYjdZ/w+HvpABcJ8AOBoDKUvPGxsgROIBuhYgeows/cBqCf+UwvKCvNr+7H/L9f
 gD51tdNJo876vLbt7ckSVpYwHmsf1I4iJR6BU8D7jFMpyLjryi07zzuUDj9d3SNqyR6M
 n+tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWThJVBmfSBwitEvdV3oxgh4UwV1ilZy/Y4ZlnKOJai117bUmM+Z22NbNbs0b1VvkeIHbG0XPJIqUpr@nongnu.org
X-Gm-Message-State: AOJu0YwkMbRvVeKhlDwkT1vlZRs6uuKsCW26g2E1XEvh5KU/4BcWaV6x
 C/WWDvURBeg+aE+NJKzqerAVh2DFF5Y7HpM+Q6OYBhHyjr6zJvW7l9mCYK7cqKzEj3w=
X-Gm-Gg: ASbGncvRazUawrJSMHIn2LQrpGEYRUAtIyPaZ+8mhSktHmDePu0xdSfRNEJMBxlQRAe
 XXdua4UHSlq5Ni6zQkWWAOuY+296bcT5fI8pBzoxIkd4O9mJ4MMsAzW/ZD/r6kEeh+dQI5MtbAa
 b+DS2Y64143qCCGMxtnFLBgc3xSgzdhCgsJpVYK/0ItBlyTG6T4yQ0ieBHLmk2bf2VMaT8RgjaH
 MVJoUn65z1CcA2V8f+a5LUegzTNT3K3txCsIXDc4XW7rgu1WbPGpen/edxSXSo282K6hHTq8UlK
 Rk8dVDD1uyPh99AAu0v5X46pihP6j91ZGwj1E2oy+XS24ftM0xVkd/W8nT6123cdCaJQmFIVl3+
 wp0hiu5EeOoh87XioC2+bVvhV7mWMQSWiOqqR
X-Google-Smtp-Source: AGHT+IGJC7uakHyMvoAJyJkNpTZq7hwH1lOUZoczgtgoCm42SM13PqRifVU82A9ispIRNhabzrdk2Q==
X-Received: by 2002:a17:902:c407:b0:265:3c3a:6117 with SMTP id
 d9443c01a7336-27ed4a6e934mr5665925ad.41.1758736738373; 
 Wed, 24 Sep 2025 10:58:58 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3341bdbf1c5sm3075096a91.19.2025.09.24.10.58.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Sep 2025 10:58:57 -0700 (PDT)
Message-ID: <74eb2a5f-b0e2-4fe4-9831-8d4229647695@linaro.org>
Date: Wed, 24 Sep 2025 10:58:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] target/ppc: Have gen_pause() actually pause vCPUs
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>, Nicholas Piggin
 <npiggin@gmail.com>, bharata.rao@gmail.com, benh@kernel.crashing.org,
 Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org
References: <20250924173028.53658-1-philmd@linaro.org>
 <20250924173028.53658-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250924173028.53658-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 9/24/25 10:30, Philippe Mathieu-Daudé wrote:
> gen_pause() sets CPUState::halted = 0, effectively unhalting
> (a.k.a. "running") the cpu. Correct by setting the '1' value
> to really halt the cpu.
> 
> Fixes: b68e60e6f0d ("ppc: Get out of emulation on SMT "OR" ops")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/ppc/translate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 27f90c3cc56..a1a97e0fd2e 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -1985,7 +1985,7 @@ static inline void gen_op_arith_subf(DisasContext *ctx, TCGv ret, TCGv arg1,
>   #if defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY)
>   static void gen_pause(DisasContext *ctx)
>   {
> -    TCGv_i32 t0 = tcg_constant_i32(0);
> +    TCGv_i32 t0 = tcg_constant_i32(1);
>       tcg_gen_st_i32(t0, tcg_env,
>                      -offsetof(PowerPCCPU, env) + offsetof(CPUState, halted));
>   

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

