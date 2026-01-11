Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BDB8D2502A
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 00:11:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vej3e-0004rU-LJ; Sat, 10 Jan 2026 19:11:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vej3d-0004rA-5H
 for qemu-devel@nongnu.org; Sat, 10 Jan 2026 19:11:49 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vej3b-0008OQ-Ht
 for qemu-devel@nongnu.org; Sat, 10 Jan 2026 19:11:48 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-81f4e36512aso205657b3a.3
 for <qemu-devel@nongnu.org>; Sat, 10 Jan 2026 16:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768090306; x=1768695106; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V+hYBM/HaYBYnRpuN7XKwwLe1hF3RDpFg6Hvln5Sfkg=;
 b=sRZhIwmvbqYhtwhIKf3SmkmnrgFNDw/2lor6oyoK314Ywbm6O2UbSKeSkj7ERMej0u
 7tQHXThgJxMRdR+HhAnhAzzGtoIld/nnNLQ5LFVL0Xs+czRPryjuvShWp5cDmWqL5sNs
 o/jq0Dm/fL5bKAiooer0RSknA5A4FWVvXFmuSocjO2g9F3v9wItJLwLXk3t0LZe4DEhS
 6kn+63jGV0VdM3Zr9jPh26QIVFjTIcZJsZWb+GlM7FmNBXo9Oc1iOvMHGhLUhhWhFyj/
 qX6ciCN8uXe+7oNw3ebZcZGc+S3odW7JBfI9+BTjtT5RqNvFVcdTCv9xRbw3rd9ndoCv
 jZvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768090306; x=1768695106;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V+hYBM/HaYBYnRpuN7XKwwLe1hF3RDpFg6Hvln5Sfkg=;
 b=TyldGIej2c414LOvZMQn6bP6o3HyD4pCKxTfv/pQW1rPNG0SfILMLu6jS/0m+OoBxn
 QsztvyKBZS1dGY7nttjuJquMmww+2jDdC0RcPmD36caAOZXTakbbap+Sx3657X48nVeB
 g50pKVcfvGzuMhcSIVQJS4FS1cc0/ghwSk9UZ1wLpWphufT/PJl4XXUNyvYLEYb2YD7R
 oLikn0DN/Nm09RGTowC+0jRNuM1ziAHVA4M6JBNrdl1Bcv/zwCLpr0M1LlPajUtphtB4
 U+d/BAMZt31ZAa748LXVbkg89lj4OBxdWJ9JljU8qA6bHOELwOQ0bOof0qARco9P78/p
 ocoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXs2pvFV+JgUq/3meV3Nela8jnN249FCHW/J/Gm1Z4iu7zeYEyrySa0lqT8vcHKqKonhrcKIF2oKcFY@nongnu.org
X-Gm-Message-State: AOJu0YzhJzkVrYCJkMopF6WxjefDf6mypmrwTGcIIqvSmd8aYG9w30RL
 669ynmmY/Yqh/6HUPJ6RqT9iP33ZZ0JUNAT4FRtoyJcsyIQq5/Y88R4nTHaTUdN9lu8=
X-Gm-Gg: AY/fxX4g1Wls1dK+CQwDAPdZ5DmpVUbBB1qj2dmh3HQBP6UHnMVGsBPpdbgEdeZUkgP
 aTufUv/Nc6FMRvbPPZjv+oHkC3XWJ5PekloVPY7FLoUX7vPgNXtcXJQ8gw/rzDnKBbVJTB6lkev
 fp+yo7Lf5Y3y/mg3tRZkHBw6xYUhNPbw6sM6fkA7pALy8JDkXABltZNY7jruPj7yYagb1vSnNhi
 zGUb+CgyahO6dARoP+uMlg9Z4GX2yjTp65vw1qcIeIDyfBRT5pE0YXnWwsNz8fUU3yvPUdy+B/1
 CWVc/k0JQNiE0EsEFD7dQapaHljZv6RMBG9kppwWcvJ0Wf/XY2kehUJytVLHK6mjVHHRVK+w8RP
 FlzHlVOT+S7hJaweA0heclGT2NdcCgO2jWyU9LLWhHle4GODUE2KbQQyui+N3R7fJgqPlqbfeFB
 MihNTjSDzuYHBmTYvnyDDwpOIoew==
X-Google-Smtp-Source: AGHT+IFFhnEuig53EGTFhHmmAhRpUOlUQPJTkN0unyeJwM56Qzq2Lb+747VleTPCvd64YFVpqq6VaA==
X-Received: by 2002:a05:6a00:1caa:b0:81e:a228:f0cb with SMTP id
 d2e1a72fcca58-81ea228f3ebmr4402715b3a.36.1768090305923; 
 Sat, 10 Jan 2026 16:11:45 -0800 (PST)
Received: from [172.23.81.179] ([202.86.209.61])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81f42658f03sm2194655b3a.20.2026.01.10.16.11.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Jan 2026 16:11:45 -0800 (PST)
Message-ID: <0d93136f-0cf0-4e13-82fe-35ad4b3716b4@linaro.org>
Date: Sun, 11 Jan 2026 11:11:38 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] target/hppa: Remove target_ulong use in disas_log()
 handler
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, Anton Johansson <anjo@rev.ng>, 
 Bastian Koppelmann <kbastian@rumtueddeln.de>,
 Stafford Horne <shorne@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Helge Deller <deller@gmx.de>
References: <20260107200702.54582-1-philmd@linaro.org>
 <20260107200702.54582-9-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260107200702.54582-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

On 1/8/26 07:07, Philippe Mathieu-Daudé wrote:
> Since commit 85c19af63e7 ("include/exec: Use vaddr in DisasContextBase
> virtual addresses") the DisasContextBase::pc_first field is a vaddr
> type.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/hppa/translate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
> index 0b7074649b7..0f8a66f7732 100644
> --- a/target/hppa/translate.c
> +++ b/target/hppa/translate.c
> @@ -4864,7 +4864,7 @@ static void hppa_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
>   static bool hppa_tr_disas_log(const DisasContextBase *dcbase,
>                                 CPUState *cs, FILE *logfile)
>   {
> -    target_ulong pc = dcbase->pc_first;
> +    vaddr pc = dcbase->pc_first;
>   
>       switch (pc) {
>       case 0x00:

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

