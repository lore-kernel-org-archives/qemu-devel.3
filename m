Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 071F8CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:03:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNiI-0003KC-Qa; Sat, 30 Aug 2025 11:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us6i2-00039N-B7
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 17:32:38 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us6hz-000738-QH
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 17:32:34 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-770530175a6so1705143b3a.3
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 14:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756503149; x=1757107949; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5Hqlc6/a7x2Z1czMBEiMziHSyqqwjw6QoDJsF0k2VYo=;
 b=yq+tdNad2ae7SOOA79IFRjQBgdth06DBKzuLA016RbaUPO7dDLCV1GLAZtgpUHwKR0
 gI/+530ZQTZ5odjTvZzLA/M/Bj97+PhMhekWVYrYVQiuKhbwxqFA951MK2DNHAhVGifx
 CrLXxp5z8LxJXKZ+YwXATUuxW/nTiYQf49MbfTZ0AjHK5qKoBg+IeoqqLs6tb2nRzCTr
 6i5ZNFehPgRGggoGjQjjGCeMTk+uufuyitVS8IJ2WO6w9zQPguD3oul8gkKBD91CXRet
 rtlQ+KYQ6Gra+y2kgaQbPhm59lJBzfyAfe1ujVl8WXVh2stYI1RLKkCK+fZo7zrOCU+Y
 7Tvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756503149; x=1757107949;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5Hqlc6/a7x2Z1czMBEiMziHSyqqwjw6QoDJsF0k2VYo=;
 b=xEKHVNUp3gNhEwUX7F+EVyUKJt6KyykA9NsaoqgZWq/9j1T9qi39S0sjDRK1rxolqI
 5c6T/almstVt3+X4/YxEX3J/wn4HLHuWnC1Dx0kri0vBUKFEv5k/WfWQQmhGWNKZGwwP
 YS7sbWP38Z/+db6Rv40xz6X1L7pflIEwFYlCDNRToKBwEkU6M1XY7QleVwPD/N0xCimu
 PgUPwwLu4q4M3D2r0Dqi1jSl7KuXrv1hYFgSOOlnlnLfbPJIVBEk9UP5FXoCxGRW3b4x
 oJ4JbYCcVS5Li7Jmibs6J+jszM1d0fN9BejAZcTLn1j8L3oEwCVrOuku7d7MDAtrCHsn
 lRqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcfT4JZBAsPcAvqrPE2FuTy121SfsXeo71Q7l7HdUxno5BQTDsGo90tYmHgWleo/im1fQjcidNEXvt@nongnu.org
X-Gm-Message-State: AOJu0Yx9sKe8BJcYT3E2hnv8WeZBg1/ktxtD6Sj7+qmBEajQoJvXKTOl
 CB6TWlKeWbCOHtnVlnbkZIqKxdal7i4qMAMFNvSZQyG7brYWZWVxK94PCOZfqbW++8CBbYL5MFl
 JddYA+xA=
X-Gm-Gg: ASbGncsZ7BSmVXoUbWWK2mL1w6EWeJmrblcq8iRDBNyKQZyQm4zQjnKhFOLKLWCwxkz
 KyLJrk4viHZRUthmL99IUhcBJuuO844NLXjuWrb8GqncBle4CKJSkA1p19yH1tlODFLZZ3UbYms
 J+f3ekaXSm/N66SOkDsVzxD64A3ZgbL/DsX2/LqQv7wdHAUq4UkO/GflZ/73h2e4mdo1KBG+81p
 hO9s/0pyYUrRW2jmwG3v6ARIFaNoBH6Ju3wsK1x7BrwlNAa/cmfWf+zpFCP31cNqzItpAaD/vmj
 rnFbcDjM5fguMCkTcfW7ehE8MEDpVdbReI/9ND+AaxN/6B+mjslurkJ7rhO2uf97M3+0ym62dhR
 8erT8ULyLokvmp8+VndR0SSbZsvApO8didwQJ9Ow1mpoM10d/PcYR7V/JiluuJDs/wOMFpg==
X-Google-Smtp-Source: AGHT+IFdaEOvtaQpJYpqdmQyUnM9VKAKiP5R6Dc+pSThBmK3sAtiPvKWw54V0xmWk7oV7QTfw9vUqQ==
X-Received: by 2002:a05:6a20:394b:b0:240:489:be9a with SMTP id
 adf61e73a8af0-243d6e0110emr133717637.23.1756503149116; 
 Fri, 29 Aug 2025 14:32:29 -0700 (PDT)
Received: from [10.118.1.198] (122-150-204-48.dyn.ip.vocus.au.
 [122.150.204.48]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a2d2ea5sm3297560b3a.38.2025.08.29.14.32.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Aug 2025 14:32:28 -0700 (PDT)
Message-ID: <56152a48-0297-4654-9934-7ca17e0e9416@linaro.org>
Date: Sat, 30 Aug 2025 07:32:23 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/18] target/ppc: limit cpu_interrupt_exittb to system
 emulation
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, imammedo@redhat.com
References: <20250829152909.1589668-1-pbonzini@redhat.com>
 <20250829152909.1589668-2-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250829152909.1589668-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 8/30/25 01:28, Paolo Bonzini wrote:
> It is not used by user-mode emulation and is the only caller of
> cpu_interrupt() in qemu-ppc* binaries.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/ppc/helper_regs.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
> index 7e5726871e5..5f217397490 100644
> --- a/target/ppc/helper_regs.c
> +++ b/target/ppc/helper_regs.c
> @@ -274,6 +274,7 @@ TCGTBCPUState ppc_get_tb_cpu_state(CPUState *cs)
>       return (TCGTBCPUState){ .pc = env->nip, .flags = hflags_current };
>   }
>   
> +#ifndef CONFIG_USER_ONLY
>   void cpu_interrupt_exittb(CPUState *cs)
>   {
>       /*
> @@ -285,6 +286,7 @@ void cpu_interrupt_exittb(CPUState *cs)
>           cpu_interrupt(cs, CPU_INTERRUPT_EXITTB);
>       }
>   }
> +#endif
>   
>   int hreg_store_msr(CPUPPCState *env, target_ulong value, int alter_hv)
>   {

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

