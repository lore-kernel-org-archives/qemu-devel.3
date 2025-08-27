Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70016CA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 04:53:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur88N-0007Lb-Hs; Wed, 27 Aug 2025 00:51:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur88L-0007LK-TZ
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 00:51:42 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur88G-0008Iu-CU
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 00:51:41 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-324fb2bb058so4747210a91.3
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 21:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756270291; x=1756875091; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3bNPfUocClaAiiuisWVX53oIO7+rfN2/xpiwTvrSO4s=;
 b=sXIvVVRz05IULH2MY2MUH1OmXw/jEqkUmDtB02CUKcxfBVRhbr00rRD7Ln22BhDR8q
 cMpW2jAZ3fJy2JK1VanuNl5yZ9Qjml1WpwYIxS0FTNDuppTqIqNa6uIuAALIm2aVNIUQ
 ENiA4U6vPZzW0m2OkILgl3sU9CumkpWolV6Ee86LeLnAOYYP7uPYVc3woMXEC/ZguYFO
 Zf13wSXQQKfbYD9rWYjCdeYT29yXkCshMEiThN6LT2xUueOC3Bfkd1VbT16h+xS6QQga
 5B9j2tzgv9qWtJ0Uo1oOf3guJt5AfxJthlgCwiCtaXkOCqwvrsD1AYOUxwha242ZS9X0
 cdJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756270291; x=1756875091;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3bNPfUocClaAiiuisWVX53oIO7+rfN2/xpiwTvrSO4s=;
 b=FPeYNm62TSWTxbGbCHqNytht//p5v/FDshn7lkxUXElIfZNRPtNZSw0q2GV9Ak+RaR
 7xhhnXNjbuM/M28TXw9SqPEDb6g1FQb6bnbbrAEU47rly0LrISli69hS3yHWJxBJ85/L
 YTbM7e58UxeTsfhMHUpCw4Bc8CxNW1bhJOeo0b92FMfXSw1MoTg+ax+YU6/Hb25zr8IT
 bB9vlG9YN4H0A8XOsvXNMaDgVn9A2t/dbBzFVncSsB4cuRurJDlIej8/5Qlu27TInq4T
 Jwmv7XCqC0gpqxO0r5Y3Us9ABnv6noHJZbU/XuEP9EJqbntzXvWd79if6EDrPagy9q1C
 /FsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKTaTxpPZdVloq6QEEroxYFYSLavhNz37FQq98WrI0w9wSDQA6U1EtDimaP42wTXBNR7IEDSMr9wpU@nongnu.org
X-Gm-Message-State: AOJu0YwNlqYCbJ7WLi5ZYeTPo+owIdMeV8JcMAllLPfNYn4iUVk0tAW7
 b/B4zexWutnfO62159BZpAtM6Oh6BHZ8hYfeat2LosnoyMROChQaYHhdBHGwEWo6e6o=
X-Gm-Gg: ASbGnctoYMzWqZvm9xF58II+mIVBGjG+snKMBQXUYicIAjcZAiEreYaEvlkZNt8XtcC
 PsAuVCP75l3tAFBKPW2RVNieSo1SGhaMUZTFtHf6umTrrY0nzlUTzj2loIXjiWZDsZMtyB/WWT5
 naN+93mLD2zJTm9VoYxeQyT2fYuqZ0NVH2Hfpp6ZFzEl+QwDJHFPOP8TFSgS5Sm5A8iRD7TuQUP
 YaNgQPEgN/KNk9y32r/sqiC6cXzsM/3IWdgKvjDUU5hG4tgAlLIMSdJ7wIBEln3IyhefhOER54M
 TqTjqcUwkBuYMRyciMyqWZMB0xbgcesqvWbhrmX0J49OGWYlWr6FCXP9VHf4r9DaCNh4YPay38A
 kzFhmbN7auTChczqabre6fvo/GxbogNFasbtX
X-Google-Smtp-Source: AGHT+IFh7c446Ez3pXXYnCgmPlAQWH12fQ1ZRxVFxYMVMXvnSP2HjTKmcqaXM5iSCdNADdSXbDpU3Q==
X-Received: by 2002:a17:90b:1fc7:b0:327:7c8e:8735 with SMTP id
 98e67ed59e1d1-3277c8eb561mr268834a91.31.1756270290772; 
 Tue, 26 Aug 2025 21:51:30 -0700 (PDT)
Received: from [192.168.0.195] ([144.6.121.55])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3276fcd3285sm844969a91.14.2025.08.26.21.51.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Aug 2025 21:51:30 -0700 (PDT)
Message-ID: <88284cce-ec2e-4641-9581-0e3bb1f9b6dd@linaro.org>
Date: Wed, 27 Aug 2025 14:51:23 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: do not use translator_ldl in opcode_at
To: Vladimir Isaev <vladimir.isaev@syntacore.com>, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20250815140633.86920-1-vladimir.isaev@syntacore.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250815140633.86920-1-vladimir.isaev@syntacore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 8/16/25 00:06, Vladimir Isaev wrote:
> opcode_at is used only in semihosting checks to match opcodes with expected pattern.
> 
> This is not a translator and if we got following assert if page is not in TLB:
> qemu-system-riscv64: ../accel/tcg/translator.c:363: record_save: Assertion `offset == db->record_start + db->record_len' failed.
> 
> Fixes: 1f9c4462334f ("target/riscv: Use translator_ld* for everything")
> Signed-off-by: Vladimir Isaev <vladimir.isaev@syntacore.com>
> ---
>   target/riscv/translate.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index b1e41cdbf1f6..980a67ea855e 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -25,6 +25,7 @@
>   #include "exec/helper-gen.h"
>   
>   #include "exec/translator.h"
> +#include "exec/cpu_ldst.h"
>   #include "exec/log.h"
>   #include "semihosting/semihost.h"
>   
> @@ -1143,7 +1144,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
>       CPUState *cpu = ctx->cs;
>       CPURISCVState *env = cpu_env(cpu);
>   
> -    return translator_ldl(env, &ctx->base, pc);
> +    return cpu_ldl_code(env, pc);
>   }
>   
>   #define SS_MMU_INDEX(ctx) (ctx->mem_idx | MMU_IDX_SS_WRITE)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

