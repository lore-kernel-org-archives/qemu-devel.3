Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 063D1C87FCF
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Aug 2025 23:17:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uksof-0007Iy-96; Sat, 09 Aug 2025 19:17:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uksoc-0007IY-3W
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 19:17:30 -0400
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uksoa-0002qp-GS
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 19:17:29 -0400
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-4b0a27ebf01so18336581cf.1
 for <qemu-devel@nongnu.org>; Sat, 09 Aug 2025 16:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754781447; x=1755386247; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Fh1P6DOqT/nInwwwtojPJ8fSiPA6xoKkNMxsb5+S3qo=;
 b=obabPfaZMGiXM0emG4fMhCpoOUZSsItBXeFzxuq7MxYbvSsiybFtOH7XVjMCCtLiZZ
 LfN5m23dyS8KyVBsEH2LEPVk6lQmUAQVis0ay+rQW4Pq6pAPP3gvkxvRh3V1snjqNuc2
 4HK4JAEg33vdWgTWxTiYP1kThCq9v3Z3EBkqPcyg23aXWg99DkJys0vq9lv6Sod5CW5n
 z6ERVgs0RzbM7cPwfJ/U/ehVPGu1l0aNPP9kvpAvtRklsNHR3OTxyshhGsK2YA0rI1UW
 59QyjhAuqC94FCiZGAlpJVJ4wUg1Pj5Kav28mQ5Hc1KeGWn+sQqYy4OhuRMYy7Auf1F8
 GslQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754781447; x=1755386247;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Fh1P6DOqT/nInwwwtojPJ8fSiPA6xoKkNMxsb5+S3qo=;
 b=Q2YIBJamosLW0zUXhkGo2FZaaFK8QW0r2cbbUKucuQx7F7+p+aaLCEYYhwbDNXYJov
 uInAfDxXPRhPj65iBqfLng6SZD9mCQNkXjyoW2TA2YZj54SEYaas5AEKw8m465VUOquX
 o0z1e2z8p5yy2VszOruZ/bW2ZakTbYdQ5zaHz5DvXjghQenwh4xBzAxDHP+psBi/C4bl
 1VAJU5JIZy/Se70mL25a2wptVnbRrziiC1LIYx9d1m6JqIKOZUZJ0ZzdQIzRSJpJ7A/V
 5+qi3wu3AVSAnvg49XT7g1kN4/r765eQGNmK4kNQ+02ioycCnuqukwlpVVQ8MPXW4MKM
 KZMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVQ2zBemEGvc62xO159rPqeOvLpyTHnfAY9xvLILB1BF39T2LL9nft/idqEsmoTOUgJpN1vflT9ACB@nongnu.org
X-Gm-Message-State: AOJu0YwyxJSXojw2eTaaAwmIvFNe5Ly5HnHrnYcBkrEDEfUVvX8phzkK
 56lX+WZe3/k/83k7Fg/3DxepMtGESgx58qieVJzdMwI+Xe9Qd0Zi/HCy1O2G+Icezac=
X-Gm-Gg: ASbGncuDTLwc/IY7tGUE9ZBLCd0O/dEekhQpAw/dikGbtVUQjm5BmUVC6+zPNmyClJr
 6HQhMlU9Bbrw9xR7D812qBc1aJikjIa/PJUMqpeoCsGtXZ1mCBkfGUvUesZFT4YnqE5WiQ8/uGy
 1NuLSz5PIyjJbeRoPzg0oRHv4iJ+Xer/3P9UdHkS3gI99A+8HEwUi0fR8BWt1dAoFNydat5dxEe
 pQJXrVNG4BEKgqfH6uoBe+17Y6GcFzk0/1QsuhSl0FguhFMW6Zb+/zpO5Wft6008I14SEdVkj1x
 69S7v/oy6eTVyFXgZpzsAcGW9Da+REzLUSGBc533q7E8bXqD26OJfTr5VeBM1EHOmq6akssW0tX
 9SGn3fRpcTN1UhZmmAhvrycSeQaFW/w6NJTn/9hL2j5yNdHFuQuzTb18UqFXPkyQ4GFHGnKZbKw
 4rWnc2ow4aMI5QPiLs
X-Google-Smtp-Source: AGHT+IFDz9aL0om46mXM5fkuEa5A5DEplm8rH7viWlSZ+iDg15CX1/N7ZWX+tRV4Tv4dTAmYBsvZDA==
X-Received: by 2002:ac8:5904:0:b0:4b0:8392:80e4 with SMTP id
 d75a77b69052e-4b0aed3680amr117521931cf.14.1754781447127; 
 Sat, 09 Aug 2025 16:17:27 -0700 (PDT)
Received: from [10.153.194.227] ([172.58.166.125])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7077ce24cd9sm132794216d6.76.2025.08.09.16.17.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Aug 2025 16:17:26 -0700 (PDT)
Message-ID: <3188806e-fa7e-43fd-9602-d6a3009272c3@linaro.org>
Date: Sun, 10 Aug 2025 09:17:17 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] cpus: remove TCG-ism from cpu_exit()
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: imammedo@redhat.com, peterx@redhat.com
References: <20250808185905.62776-1-pbonzini@redhat.com>
 <20250808185905.62776-6-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250808185905.62776-6-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82a;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x82a.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 8/9/25 04:59, Paolo Bonzini wrote:
> Now that TCG has its own kick function, make cpu_exit() do the right kick
> for all accelerators.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/core/cpu-common.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
> index f189ce861c9..045b1778236 100644
> --- a/hw/core/cpu-common.c
> +++ b/hw/core/cpu-common.c
> @@ -86,9 +86,7 @@ void cpu_exit(CPUState *cpu)
>   {
>       /* Ensure cpu_exec will see the reason why the exit request was set.  */
>       qatomic_store_release(&cpu->exit_request, 1);
> -    /* Ensure cpu_exec will see the exit request after TCG has exited.  */
> -    smp_wmb();
> -    qatomic_set(&cpu->neg.icount_decr.u16.high, -1);
> +    qemu_cpu_kick(cpu);
>   }
>   
>   static int cpu_common_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

