Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F287C0219D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 12:43:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiYY7-0002Fz-Qk; Thu, 13 Feb 2025 07:42:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiYXu-0002FQ-C5
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 07:42:22 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiYXq-0006Rj-Tx
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 07:42:21 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-38dd0dc2226so560741f8f.2
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 04:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739450536; x=1740055336; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uV75d/834kcmmWrk8GWRKTLRQKsgSE0P/62g5SmLQBc=;
 b=eGTEdl+rrSRnyljhnvhAxSZbqOt71JEdmDrGH2jI9e7o2CgcEdh/KiTtxGlOuYGcyW
 yB9Hh/LNAtMaSOwGkE1a4qI7Isvs6f4UgmvXcNYrv5eKXLIhwRTHrxF1XZhg0ZkRne1K
 Y/F3Gw8VQUEn7/mdih1iTJ7aNex0ksdAXllCxnWC/w9tyyTyvvxAx5HwYXYTZsUhML4O
 jBSaTXEWqE7KJRmnXoioB3KLpWBOsRtd7A0tXkXoaEs+K3FbqSXFYhZL1IpC0QStQeN7
 KYhJDjewNKStjH2FIpfC3q0wbJJdhNorbIfRleE0KFG9+FghaCxZlFbcWARqlLM1caYq
 QyNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739450536; x=1740055336;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uV75d/834kcmmWrk8GWRKTLRQKsgSE0P/62g5SmLQBc=;
 b=vbD4izlLN4eXP4COttaT7z/KFhtlHaf31triqw4daYLg/FLHxZcWy//v6xGuKxdNLL
 MCFVuOgY9x/4zR+0E+07VnRhscd8dGBXHkQUxQZsql+rfC78ZRidF7YcoJ996Yem4jyi
 dhmkibs58PpCfabYsuvb82x4aM8cXBHq7Q+2uyyFjzGuIvNf80rKTQMkhwqm01Q+TE34
 t+PbMXmu4bJZCJjRgHvMZAdqrBxZ6nl7M/i2u/cAjwTSWiQi9HNDHgyXMxr+cIWsaZzA
 3KJtKfCtXUVasCdTT++CJcSJOJavcOalRAOIfdZGHg8ESGD6DkNkrhA4mD+1GT3gAmr4
 TjrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHoVfqqRHbIoGgSlO8le3WLiHNOg3SKVR5pssJiK6sq7tWepByRqORVMy6GcHBpXGfyBo1JIud7r7m@nongnu.org
X-Gm-Message-State: AOJu0Yz3gX35RgXCoU88zWopxUy8JzyEsUOLljPbkb0pkbw7LNfveXVE
 2kKdRz9OUJzBdHklVyjS3Rk4klMhDZ3JimKFGDyXo3zh9W115RSeagaOzeZZPEvVjTLIC4cniw8
 XVR4=
X-Gm-Gg: ASbGncsiEmmQwiyDrxhw5Fx/MIgeqvScUSfql8R4CV/IlHhDSSHrg/7murV4qvlmRAK
 jSQ/b1CKrOY6pIMV/f6PNueWOVBUm6rrCxbZutyUGlB7fJrNBsMdjlNjhCIlnr4rdQSZL/HL3MX
 X7pgQOsikKQL2y94L2XA6rzLo4kaYvgo6iNkhbIANSPWqs+pIzlVkJr+pftPOAimpgpY9+Id6bh
 XVzfKJclbbNCCfzL6F23D/tQpSFGr0lK87f/smqk7/Ad0zBC7nx/FXAW6AIZxNwNd8olIJZU+yD
 jfuTmyoLZhKfnFkVuD5L9xm/Oog8a2AyIWGpLtWKDffbgjv3ZtU6
X-Google-Smtp-Source: AGHT+IEXadKwRWx21mh2wydRaRjuzVdN59k/CQwifxHAw4o8BdABoWHs1ofrKFliMCP7NrT545ti6w==
X-Received: by 2002:a5d:47af:0:b0:385:f7d9:99f5 with SMTP id
 ffacd0b85a97d-38dea2ea062mr7335357f8f.51.1739450536532; 
 Thu, 13 Feb 2025 04:42:16 -0800 (PST)
Received: from [10.223.46.213] (6.170.88.92.rev.sfr.net. [92.88.170.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f2591570esm1816521f8f.59.2025.02.13.04.42.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Feb 2025 04:42:16 -0800 (PST)
Message-ID: <5b0a2b4c-7c70-4d3d-96ce-855feced435f@linaro.org>
Date: Thu, 13 Feb 2025 13:42:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] target/microblaze: Use uint64_t for CPUMBState.ear
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com, Anton Johansson <anjo@rev.ng>
References: <20250212220155.1147144-1-richard.henderson@linaro.org>
 <20250212220155.1147144-5-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250212220155.1147144-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 12/2/25 23:01, Richard Henderson wrote:
> Use an explicit 64-bit type for EAR.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/microblaze/cpu.h       | 2 +-
>   target/microblaze/translate.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
> index 45f7f49809..01571d4f86 100644
> --- a/target/microblaze/cpu.h
> +++ b/target/microblaze/cpu.h
> @@ -248,7 +248,7 @@ struct CPUArchState {
>       uint32_t pc;
>       uint32_t msr;    /* All bits of MSR except MSR[C] and MSR[CC] */
>       uint32_t msr_c;  /* MSR[C], in low bit; other bits must be 0 */
> -    target_ulong ear;
> +    uint64_t ear;
>       uint32_t esr;
>       uint32_t fsr;
>       uint32_t btr;
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index d5c5e650e0..549013d25e 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -1842,7 +1842,7 @@ void mb_cpu_dump_state(CPUState *cs, FILE *f, int flags)
>       }
>   
>       qemu_fprintf(f, "\nesr=0x%04x fsr=0x%02x btr=0x%08x edr=0x%x\n"
> -                 "ear=0x" TARGET_FMT_lx " slr=0x%x shr=0x%x\n",
> +                 "ear=0x%" PRIx64 " slr=0x%x shr=0x%x\n",
>                    env->esr, env->fsr, env->btr, env->edr,
>                    env->ear, env->slr, env->shr);
>   

So IIUC no need to worry about the upper 32-bits as Anton
suggested in my RFC:
https://lore.kernel.org/qemu-devel/rbczkcp7whvovj55htcvongsc45xyhia5sgckqunszldag3iey@4vsbsjak4wr2/

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


