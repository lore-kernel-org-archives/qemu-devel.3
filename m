Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AF72C54ED1
	for <qemu-devel@archiver.kernel.org>; Sat, 24 May 2025 17:31:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIshq-0006No-ON; Sat, 24 May 2025 13:30:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uIsho-0006N4-ME
 for qemu-devel@nongnu.org; Sat, 24 May 2025 13:30:44 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uIshj-0000Gt-9M
 for qemu-devel@nongnu.org; Sat, 24 May 2025 13:30:44 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-442ccf0e1b3so11403305e9.3
 for <qemu-devel@nongnu.org>; Sat, 24 May 2025 10:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748107837; x=1748712637; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0YwJjzLqPfmTqHPk0OYV/G1ZrhUpumbkktem1Lb3OzY=;
 b=TmW2N+opISuaUV2+0GPB1aI+gW2+yhUYMGfMyNAAJODFz8uzc1rBBQV7cSKPGOcw6a
 zszQ2aMpxx7z4v2L3T0HwWzyWQVFO4/PWyv46BWN4t5I2OLuaacS986gn5qU3nsvcjjc
 uUi8bjYBpR9UnSAM9JPNfBzeXbPnpY9wIkCNQjPJMo8B0lkgNGUBYeGa1ej/mSXFcdqB
 0Uq2cqikGIxxAyCJ5UwCu0HPf5I3TQ/3LsgdgYv21f67cfIRn9K5y04wgyGS/hLyit5Y
 fRhfvbi9K7vmx+yLI3WpI76HKTSdslbMB7ue1gw9+8PyFGp8FNeX2CBhIoto+W99Bodc
 6IsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748107837; x=1748712637;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0YwJjzLqPfmTqHPk0OYV/G1ZrhUpumbkktem1Lb3OzY=;
 b=tpQeE/KFanA8BcJ+BmTHdukkX8dRXNPzG+s+K8kuc7k9IoDLnd1DAJrPmyUYJs2EKb
 2hq3kGCC2OWPhqlPfHWgA8np76CGy2TJytVxpfEvb3Me1NhVeJBlKp+QF+iHP/1OGxtc
 l0UwaHBcnClo1lgKqh2Yi5Bm1F1SLiCzoFgsaUto1ijmu5ExjUfm6MVXs69CuHideSfK
 9wvFUxHTGRLzRRo9CX93na+CchxOJVF1Uo6Gt4lDuxFqEtxBsrcfW9VkztYWyUn1cfn9
 mLlMzG4MqBK02gkSzvf+oAlqHP8WNyOG1D/X/I+EFl+YcQ80Vr1lpiD1STeVEeUcV0Vz
 c6mQ==
X-Gm-Message-State: AOJu0YwZ0w83oRBLY7Sq1mRiyeLjlPI9mqfhHs/IhHRIS7psEzOxWlcL
 31SvtdLFtX/rBkQI8axdbwfCKyz8RwKjQynsrT6C+oLHsKkswft8bBqCexbwOEoftbgMd5AFeSc
 eXWw4y4kgcw==
X-Gm-Gg: ASbGncsuoVJAs80NosNu3jHiRymAd7RvgNhDGb142XWq2jBnWl4BA0tFKwTL6R75kkG
 Ru2IzIDSE1jBVGtRdmZCNwnAK+4Jt9yPtXuUQTwR8DVo4Qyvn9gSso0kGBYF/L1PbSO4CBxowiH
 X1c3bjgBUpAVhwHTdbh6eWJHPq5fw4RZSVK7D0EoxPWOzHIhbOFjGrXnUdR+oCpCb+tlLd0Yk3+
 b2Gx3Zj+RxDmQ+l0ql24yXGhUfFKyrEps/894qKAWT3pIfXgk9tEWjr5Ko+rBhCr019nwG7D5HD
 ZmNTR8uAlwfLgT5MTHnUUgS9lGsfvY1SBcn+MD8jXxoRsGzcOSbSi/F/OWoKezE4zg==
X-Google-Smtp-Source: AGHT+IF31g1amaC8Yu9niBtSYVonXBOLzC/XTZuAzS8stke047Z7JwdAZql5dw0Vk0e0fsfkVLKUNg==
X-Received: by 2002:a05:600c:6612:b0:43c:ee3f:2c3 with SMTP id
 5b1f17b1804b1-44c91607197mr27541225e9.7.1748107837397; 
 Sat, 24 May 2025 10:30:37 -0700 (PDT)
Received: from [172.16.25.47] ([195.53.115.74])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4cbb90a5bsm2977358f8f.56.2025.05.24.10.30.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 May 2025 10:30:36 -0700 (PDT)
Message-ID: <8879f07b-7d4b-4013-b798-a59d6a69bb48@linaro.org>
Date: Sat, 24 May 2025 18:30:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 15/25] target/ppc: call plugin trap callbacks
To: qemu-devel@nongnu.org
References: <cover.1747666625.git.neither@nut.email>
 <bc32d3f37c3e8d33e7f1c4f0d08b858d934f1ecf.1747666625.git.neither@nut.email>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <bc32d3f37c3e8d33e7f1c4f0d08b858d934f1ecf.1747666625.git.neither@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x332.google.com
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

On 5/19/25 16:19, Julian Ganz wrote:
> We recently introduced API for registering callbacks for trap related
> events as well as the corresponding hook functions. Due to differences
> between architectures, the latter need to be called from target specific
> code.
> 
> This change places hooks for Power PC targets.
> 
> Signed-off-by: Julian Ganz <neither@nut.email>
> ---
>   target/ppc/excp_helper.c | 42 ++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 42 insertions(+)
> 
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 1efdc4066e..24740a000b 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -27,6 +27,7 @@
>   #include "internal.h"
>   #include "helper_regs.h"
>   #include "hw/ppc/ppc.h"
> +#include "qemu/plugin.h"
>   
>   #include "trace.h"
>   
> @@ -404,11 +405,32 @@ static void powerpc_mcheck_checkstop(CPUPPCState *env)
>       powerpc_checkstop(env, "machine check with MSR[ME]=0");
>   }
>   
> +static void powerpc_do_plugin_vcpu_interrupt_cb(CPUState *cs, int excp,
> +                                                uint64_t from)
> +{
> +    switch (excp) {
> +    case POWERPC_EXCP_NONE:
> +        break;
> +    case POWERPC_EXCP_FIT:
> +    case POWERPC_EXCP_WDT:
> +    case POWERPC_EXCP_DEBUG:

I think DEBUG is an exception.  It's synchronous.

> @@ -758,6 +787,7 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
>           if (lev == 1 && cpu->vhyp) {
>               cpu->vhyp_class->hypercall(cpu->vhyp, cpu);
>               powerpc_reset_excp_state(cpu);
> +            qemu_plugin_vcpu_hostcall_cb(env_cpu(env), last_pc);

Err... I think you need to be more specific about what you mean by "hostcall".  Certainly 
this isn't the same thing as semihosting.


r~

