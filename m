Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7DA0C369B2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 10:51:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4HPH-00024W-Pc; Mon, 14 Apr 2025 06:51:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4HPF-00024M-Qc
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 06:51:14 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4HPD-0007iN-AE
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 06:51:13 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso32089395e9.0
 for <qemu-devel@nongnu.org>; Mon, 14 Apr 2025 03:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744627869; x=1745232669; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RTpBihjU1sJ7y0H/RxUDz0ZJdLrXxiTPNolIl+hDQ5o=;
 b=Cai8K9TAyCcaSDUwXytshbWtaAF9bBkqF5vsJGVcLbiJVQk2tEzvP4O3stjckekn/0
 qOYx9+tSeYHVVtYSJzxjpyBQJPqvcD7SkcWdWBKZ1+gac6W+2SfguNcKfkRxjmnfV+Ns
 YtY6EahmdSW1EBsz+w+L0GHWu08IOTRZ05xgOKJx+u740qZRgiHR2WwvmYhtoRTfamCe
 qAyYqVp7NhtGLqaMwmBWvPUANUnoCEOUml58+Kl9yTXp+y3XxTndCowKTgLxN5K5nL07
 r6ciGaazlbjQkl8Xvpe3rYZgXaC1ICh+eqpScmNAqwROeIGJMW4Wz2mLYUqLI9oDGphx
 psqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744627869; x=1745232669;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RTpBihjU1sJ7y0H/RxUDz0ZJdLrXxiTPNolIl+hDQ5o=;
 b=eVzcbvrkxHpLQpYybKkz575KX9RTS1/bdGUYDUlW3QaOkXAFdOHEuHgNoDNFHgbvyY
 b3ecNo1wiPLMsxZVj168/Hp9nroD9JYpA1HYof2D1tkzU/MSAMgkLHeP5Qwire8d9qcO
 NqcVjzzZ1V8R6275/TZq5GQMaSJPIBihLDaCWh5pxlXtrCeViN2YQkKKZ7jBdju18M0G
 zsEC/XgbrURc/YP5/skLUq5Z3b+/mHnD07t48o2dn4/G5TBJqkHlVD1OK7LhIlA+dvC5
 nR1Joc8J/UL0oEwM4PAsJuMgPvZon0t8N+zBOpt4L3mw+//da6SSO9SAmmCp1Ou4ysnl
 W5oA==
X-Gm-Message-State: AOJu0YwxA1ZUXIYdR73GkQLs16MljT6f2BpoCkEaeJcd9YpcOL+XMDlg
 NzUwmSHofHUb/u+2XbX5i0Qj+tTFnIhwIjAPjtvUqcjRbwZTjMQyKtTFPh0blg9JhDczgwEJB9f
 4
X-Gm-Gg: ASbGncsyfrebdBcZybYwpuPyn4A/fizbYV0mJj4iwSG+LQ+Kmyp81oy0sgXE7QsWm3k
 YkveBTFTWTBgtgCk69kEfufS/Ea65k+Ty6jsSyPK+gzqy+p3mPfQB04tRBdHnSeNdMBPacTFg6E
 NT8sZtp5QoI4W3snGOF/At6ylQBZHgbtGTWu1lnwn+9S3Zcl6py9BV0cznsx/72tfM91e8b6sk4
 mmP3QhNqctwbeIIMZ7wZKJ1wzWwJUDrWTiWddVy7iupSDy6BC0dUy9JmW1CdaZBzRQnfl+rXH21
 QQUSAyGop1NITt6GTEtZ8t+WdH2qRs7OnwIxih9dcug0JOwl2IewK0TPseW2fYjBBwmBy84yqGa
 HgC4DBZcgR2mwbffvHF4=
X-Google-Smtp-Source: AGHT+IFm1VK6lyqYn8hSYNEl6iS0QRfCnTlhLSQw9U4Dxk4ButGKtHbVT1UclekeBOJQDe9rBkli1w==
X-Received: by 2002:a05:600c:4e09:b0:43d:45a:8fca with SMTP id
 5b1f17b1804b1-43f3a9b035fmr125123305e9.30.1744627869263; 
 Mon, 14 Apr 2025 03:51:09 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f23572bb2sm172792055e9.29.2025.04.14.03.51.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Apr 2025 03:51:08 -0700 (PDT)
Message-ID: <24b30fec-026c-452d-9d2b-bf8fd5f4c944@linaro.org>
Date: Mon, 14 Apr 2025 12:51:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] target/loongarch: Set function
 loongarch_map_address() with common code
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
References: <20250414012528.4075447-1-maobibo@loongson.cn>
 <20250414012528.4075447-5-maobibo@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250414012528.4075447-5-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 14/4/25 03:25, Bibo Mao wrote:
> Function loongarch_map_address is to get physical address from virtual
> address, it is used by qmp commands to dump memeory from virtual

Typo "memory",

> address.
> 
> It is used by kvm mode also, here move function loongarch_map_address()
> out of macro CONFIG_TCG. And it is common code, the similiar with

"similar".

> function loongarch_page_table_walker().
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/cpu_helper.c | 17 ++++++++---------
>   1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
> index 6736a9a330..7a56482282 100644
> --- a/target/loongarch/cpu_helper.c
> +++ b/target/loongarch/cpu_helper.c
> @@ -155,6 +155,14 @@ static int loongarch_get_addr_from_tlb(CPULoongArchState *env, hwaddr *physical,
>   
>       return TLBRET_NOMATCH;
>   }
> +#else
> +static int loongarch_get_addr_from_tlb(CPULoongArchState *env, hwaddr *physical,
> +                                       int *prot, target_ulong address,
> +                                       MMUAccessType access_type, int mmu_idx)
> +{
> +    return TLBRET_NOMATCH;
> +}
> +#endif
>   
>   void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
>                           uint64_t *dir_width, target_ulong level)
> @@ -283,15 +291,6 @@ static int loongarch_map_address(CPULoongArchState *env, hwaddr *physical,
>   
>       return TLBRET_NOMATCH;
>   }
> -#else
> -static int loongarch_map_address(CPULoongArchState *env, hwaddr *physical,
> -                                 int *prot, target_ulong address,
> -                                 MMUAccessType access_type, int mmu_idx,
> -                                 int is_debug)
> -{
> -    return TLBRET_NOMATCH;
> -}
> -#endif

The change seems incomplete but fixed in the next patch. Maybe rebase issue?

