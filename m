Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39AA9C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 00:59:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1FM5-0005Zl-7x; Sun, 28 Apr 2024 20:58:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1FM2-0005ZD-NN
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 20:58:51 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1FLz-0005ej-Lt
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 20:58:50 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6f3f6aa1437so773981b3a.3
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 17:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714352325; x=1714957125; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sw/q+A6bwASHZa+nmPnQ6eHKVTcwAx85ALMU6nNIpm8=;
 b=nzXXF8DXnXYANB8idFl5f1JbxUUL9hMeo+bCmQVohQcrSKXcPUPmf8AGlVtvtb3Fm5
 9m+4+ikchP90ArfElMNIjvq2qTbEml8RI/KQOhDF9OaRjdujYWYB9Lkkq4ROMyqBhmBe
 YMA4lsFNOkpY/uQ6q6B50Gg62WFZO1I7wE6kWq1KwV+Y2YGkrFPSewGWJMD5vWJ9/GAa
 83rX+eZyI5PFAvv0xCnMBSWCOXQX6fWlPonGcQ4UMfvMuNGifVLYeB1wstMqSYQQhTVF
 SobPK79PKlc1mWmhVwqkcErpCmFccMee0s/XIyXg4d5pBrsZq0+NNrICQJ1ZrWEwHevU
 /aqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714352325; x=1714957125;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sw/q+A6bwASHZa+nmPnQ6eHKVTcwAx85ALMU6nNIpm8=;
 b=K0VQmgV7GpWPDbd2Fi6xLrAskrL1mcO32svZu+dGp/+DKqqJka8AmBkcGiyQxtgkYi
 Ds4/YZpegajxu36t5gODTQ93kv+w1kqy9qwIKqzrCC61IW/Q3GPuvE7HdCUv8M5d8bDp
 jZp4cK4mN8WgzRLv0+htVBI3WSSLqInqtC5pecL2xDDznJVByB26fgvHcA5KrPq0KU5u
 DBCjcnt+mbq6TSO2G7BTgqYxpYyH915jnvbYwoTNjGDGZiQJCT4cjl8XANvk72gWI+gz
 m6rhzgxldElPKFkCIQ2Tw74T9kjh7wr9kHLW3Uh+VTv79Ev4o+FolYu/t0rm28RQB3xW
 3q4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVq7i0wmysNf1cgfpPQrMs5o1qq78eDEZf0TVrJTaaiS0LvgsHcH9CZNw39gS6cyAHfIawB+EeNgf5ypxHNugv/CHGF/Kw=
X-Gm-Message-State: AOJu0Yy4+lXP+4dHZ8DZlwUD6pZqf/k08wc/jHg9cn8G13nfkr5c1rV6
 crDgxTifyC7YbPk5SnbQdNbJkTFozaZTM4dgfdbS7j2AnLL/yYSh30iAX8TYARKSWXWmcEdcxd6
 h
X-Google-Smtp-Source: AGHT+IGtrGY+9ZxsuFbQOFtamwJRsfTZyKLBeLak/Ql7LuLmfjAO17N4t8EUiO63Qf3IUJJXxdVddw==
X-Received: by 2002:a05:6a00:4787:b0:6f3:e6e0:d9fb with SMTP id
 dh7-20020a056a00478700b006f3e6e0d9fbmr5023497pfb.11.1714352325243; 
 Sun, 28 Apr 2024 17:58:45 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 k4-20020aa79984000000b006f3e3d928fesm4176736pfh.220.2024.04.28.17.58.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Apr 2024 17:58:44 -0700 (PDT)
Message-ID: <5cf1b183-9d33-497b-88a3-7c55dec1e980@linaro.org>
Date: Sun, 28 Apr 2024 17:58:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/24] accel/tcg: Duplicate cpu_exit() for user / system
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
References: <20240428221450.26460-1-philmd@linaro.org>
 <20240428221450.26460-5-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240428221450.26460-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 4/28/24 15:14, Philippe Mathieu-Daudé wrote:
> We will introduce a per-accelerator vCPU exit() handler
> for system emulation. Duplicate cpu_exit() because the
> handler won't be accessible from user emulation.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/tcg/user-exec.c | 8 ++++++++
>   hw/core/cpu-common.c  | 8 --------
>   system/cpus.c         | 8 ++++++++
>   3 files changed, 16 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> 
> diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
> index f49435df9d..404d8a145c 100644
> --- a/accel/tcg/user-exec.c
> +++ b/accel/tcg/user-exec.c
> @@ -46,6 +46,14 @@ void cpu_interrupt(CPUState *cpu, int mask)
>       qatomic_set(&cpu->neg.icount_decr.u16.high, -1);
>   }
>   
> +void cpu_exit(CPUState *cpu)
> +{
> +    qatomic_set(&cpu->exit_request, 1);
> +    /* Ensure cpu_exec will see the exit request after TCG has exited.  */
> +    smp_wmb();
> +    qatomic_set(&cpu->neg.icount_decr.u16.high, -1);
> +}
> +
>   /*
>    * Adjust the pc to pass to cpu_restore_state; return the memop type.
>    */
> diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
> index 9b3efba82f..cbafc79033 100644
> --- a/hw/core/cpu-common.c
> +++ b/hw/core/cpu-common.c
> @@ -78,14 +78,6 @@ void cpu_reset_interrupt(CPUState *cpu, int mask)
>       }
>   }
>   
> -void cpu_exit(CPUState *cpu)
> -{
> -    qatomic_set(&cpu->exit_request, 1);
> -    /* Ensure cpu_exec will see the exit request after TCG has exited.  */
> -    smp_wmb();
> -    qatomic_set(&cpu->neg.icount_decr.u16.high, -1);
> -}
> -
>   static int cpu_common_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
>   {
>       return 0;
> diff --git a/system/cpus.c b/system/cpus.c
> index 68d161d96b..e0530ad603 100644
> --- a/system/cpus.c
> +++ b/system/cpus.c
> @@ -419,6 +419,14 @@ void run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data)
>       do_run_on_cpu(cpu, func, data, &bql);
>   }
>   
> +void cpu_exit(CPUState *cpu)
> +{
> +    qatomic_set(&cpu->exit_request, 1);
> +    /* Ensure cpu_exec will see the exit request after TCG has exited.  */
> +    smp_wmb();
> +    qatomic_set(&cpu->neg.icount_decr.u16.high, -1);
> +}
> +
>   static void qemu_cpu_stop(CPUState *cpu, bool exit)
>   {
>       g_assert(qemu_cpu_is_self(cpu));


