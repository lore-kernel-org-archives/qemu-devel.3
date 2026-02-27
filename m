Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52AF7FD9E2E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 03:00:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvo4x-0004mQ-ED; Thu, 26 Feb 2026 21:59:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vvo4v-0004mF-Ft
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 21:59:45 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vvo4t-0006lA-Vj
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 21:59:45 -0500
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-c2af7d09533so958586a12.1
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 18:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772161182; x=1772765982; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T7DXTBWMVlv4VKDENfYBAt7nb0lnyJwHYAeX0Gfxmuc=;
 b=DVESi4li0YS4fytytH3FR4Vj+/G/nqQWAYr98zvMDXdc4TuMhjpj3vZoVny8rZFmUf
 M3k1D0upZThjLdeCNlEf0gjKMih2uc2YcWPciPMDNNfbvNB2VXgnDs/atU9lmdJa5NsO
 6f+W1JrPeOOzt3C5zzIfccXiG9XMMgibOOokBecJrCcYusmGgi/pywLalblDYrCyvrdC
 IVzxD35VSQG8ksdTpKIYXcsnsQJqKBGsBafzwj1VBlmLVreUwAO/GlEo/vb3ocowMEuc
 CXCRtz4TilPNJqSrX1GYBhei30zVJBV99EDrTu1Tb0vY6HzDB8noa9lSUB1CtSIuaq0s
 lb8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772161182; x=1772765982;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T7DXTBWMVlv4VKDENfYBAt7nb0lnyJwHYAeX0Gfxmuc=;
 b=H9Ete1XpUBud9aEs9sQYmAou//rED0ucDcnVU+M+ie996JzcuiHH2EEx8XOlKDmjnn
 G5cc3aNnvgb1fkAnUOSNBvFLpUqA1Fnp2JmrXOumHeQ2PEEKxrRLjwN4dVZtL/0j5p55
 EvM0xhSA2b98IVyhqVX9VQ7GDIsuf96+NNsR4riquYhX/iGEhIEuyngD7v78XgYaWf/B
 OjK1wV//vGRaHAwu8RA4TOUgFfiqgYa/7MQEMXxfbjqhhXmryC6V5MIZ7DHE+4D5K6DQ
 wEerV+KdaRSz1oEeIKCFagyeDiHWi9f7/6CcNZ7VtlJGwzDzy3hKnHOgC+qik/N7ryL1
 31Sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWROx2eDYDK2TqqMr0H5sUMn0Tfhd8tNj0soCL92/be0lMwrH/JKAXXfQ/83C/q0s2HHJb1JvUw4gFL@nongnu.org
X-Gm-Message-State: AOJu0YxtUFo4XdHAenTMTolCAGwm68rr82vrSaymBZtApqqGPwalImYC
 eoX4sIqZLIo2fuop3amyb7aMBNmAhGIZRQNsBNWs8TvGgVKX76GtLdSpoKDZYidep1c=
X-Gm-Gg: ATEYQzxa8WgtPolDOj/u3O/HngKHrHzv2sdG6dUYVsDR941XEhUheU9b2PMu2mCQ00V
 qKD29HQ8IOyd7k8trlZzb45/3NLbvmejhdZyEUGCS1Y9L8ajlYRdbXXbDYZEMfCJAmyoWDFaOG9
 /HreWZs57Sjpv791v7MIyTohOzvcyWDcY8rABnzwhgYk7aRxLveHnR4+KNIAV81clgfv2qDAe+x
 xX2XhISxYPfLI3Aa3ehlJY3DpasU8AKvp6ny/lki59/tKEP8CjA1HThPlcGvHmHA4tE+itpHCOA
 ihmeh+4ZgLtZ7cnqKRWQY2k6UldCdMilZtPuVny5PF6Ovv3EmogEHz3zDnXHZilMjV7CH6dWEHh
 uLlSDTGVa/y1x38zHHmKRXJK0LfYXoq1tm/3Am0iTs6i0SX6UTg4vEZqTfYjkHM6LqAGe97FUzH
 XlncPFwzE1kUzlZY5b1ue7j6eqUd7vT236E9uHav0=
X-Received: by 2002:a17:903:46d0:b0:2ae:2b5e:dae with SMTP id
 d9443c01a7336-2ae2e4b9abemr13649175ad.47.1772161182139; 
 Thu, 26 Feb 2026 18:59:42 -0800 (PST)
Received: from [192.168.1.38] ([180.233.125.15])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2adfb69ef1csm43696165ad.53.2026.02.26.18.59.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Feb 2026 18:59:41 -0800 (PST)
Message-ID: <ee6e6c7e-658c-466a-b617-1a34ea8659cf@linaro.org>
Date: Fri, 27 Feb 2026 13:59:36 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/hppa: Expand tcg_global_mem_new() ->
 tcg_global_mem_new_i64()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
References: <20260205212914.10382-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260205212914.10382-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

On 2/6/26 08:29, Philippe Mathieu-Daudé wrote:
> The HPPA target is a 64-bit one, so tcg_global_mem_new()
> expands to tcg_global_mem_new_i64(). Use the latter which
> is more explicit.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/hppa/translate.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
> index 0f8a66f7732..70c20c00377 100644
> --- a/target/hppa/translate.c
> +++ b/target/hppa/translate.c
> @@ -307,9 +307,9 @@ void hppa_translate_init(void)
>   
>       cpu_gr[0] = NULL;
>       for (i = 1; i < 32; i++) {
> -        cpu_gr[i] = tcg_global_mem_new(tcg_env,
> -                                       offsetof(CPUHPPAState, gr[i]),
> -                                       gr_names[i]);
> +        cpu_gr[i] = tcg_global_mem_new_i64(tcg_env,
> +                                           offsetof(CPUHPPAState, gr[i]),
> +                                           gr_names[i]);
>       }
>       for (i = 0; i < 4; i++) {
>           cpu_sr[i] = tcg_global_mem_new_i64(tcg_env,
> @@ -322,7 +322,7 @@ void hppa_translate_init(void)
>   
>       for (i = 0; i < ARRAY_SIZE(vars); ++i) {
>           const GlobalVar *v = &vars[i];
> -        *v->var = tcg_global_mem_new(tcg_env, v->ofs, v->name);
> +        *v->var = tcg_global_mem_new_i64(tcg_env, v->ofs, v->name);
>       }
>   
>       cpu_psw_xb = tcg_global_mem_new_i32(tcg_env,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

