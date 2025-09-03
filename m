Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 119DBCA0FF2
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 13:08:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utnDb-0003hf-2Q; Wed, 03 Sep 2025 09:08:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utnDZ-0003fv-EE
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 09:08:05 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utnDX-0001Xz-FU
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 09:08:05 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b0472bd218bso53499166b.1
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 06:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756904881; x=1757509681; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7xNLtrB3tqw2BBsrA12DUE/ErdmpKDz1YLrJiGjTrbk=;
 b=WolwQXELCgP6tgVIxTp0T0EqWOak7h5ob74ggVQ/bdqJwzG7asqDy44cRp1R2o/5K+
 kKXZGmrxYla/kFGKD+gU5QEGKPraLwG8FWRQ7eKs9LEawxhgJU4YTk1K+exp6O83pyA7
 BWZGg9QQWKIwixsB1k0aIxV5YnGGkuB3oMNFtowGi29Vc+GKDPmE8fPVKJLWlLq0Frvk
 mDytVIxqftohPaYfm4svA+75p745x6Ca9DWg8SG3AZaz6YVJrVCN0fmwtDHJVvVoazq5
 6OxHpki08r8FjmDSMP8WWBeQ/O1cdEJvkO9AphIXNvkg1r6+p9w4+9ar8uJilrSFtW8m
 jPTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756904881; x=1757509681;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7xNLtrB3tqw2BBsrA12DUE/ErdmpKDz1YLrJiGjTrbk=;
 b=nKbUYtFDlM/5Ln4hDQChHttn6AmbWC9Ncx0AMU4w/znL4nvQ7dKQi/TJH5Ylr8CVEf
 7SWWYwqC/QHGp1/2kHpAw5o/k4q7dYjswOjLooVDk7WJS4Dfn4Jgef3WRdv1DU9dVDrm
 TaHfr28aLkHf9uXf7vudEFZyF55kbMh9rWLnXn0EActElOvoj47So/Wk6lKkphLAFMqB
 5eX6EyPXPAQPwcDuEEPnKC4h5ImnJsN2NiCvXTwUtBfo1r7E0F0jiPVpZ5KjM5HpZQ4m
 kOvJjNVOSaGPLZ5lcritx+jcoCzOh3uAhwgRv/INQoiChTCQdFCcDgYRAOZT2Yx56V3k
 QQNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSIUan0GwGalrGTXSdoRTx2lYPASLvF2brAcpUA2f8Ara5ZV8TjHkQznhn8tAmkkMykTB1dymgnHk2@nongnu.org
X-Gm-Message-State: AOJu0YydtqJneIYLFsJFJGXcuc2VZsPrmw0/akJPIc+1ozGFam0tr0jw
 T8RZF//XD/2lu9bDMm1h1j4yZnMSQ0oMQva+TRMs94GfsckjoUlYIKRBdR0H9agrrf+BksMQKSW
 oD7tNqRQ=
X-Gm-Gg: ASbGncvgXqxkVXvsNtsx1lpninq2kAivleOvjoJs41ViS4BY1vARXf0Fi5kqCceuRcl
 hIIP+P0pDLJSa3X4NKjvzay5n3CC5bh85+jgA9Gzpcy+zFqLM5TalLWlVIC1OLNaQMlj4RVYLPz
 BN4lj5sknJDvesR22JeK6KzkAhqRxQ/GvQ3ciQotMPtShUc+4TpwFTcOxn1g+507p76Xj5ZsG7y
 Q32UyClX/+MLbjfPlZV6dFOE8eQy9C1BFXO6KLnjJ5cELLPlGuyakLokmTSRjDFF7lLeapq87+y
 P5q8ZaCesckx/4g4XNSUzYD0AHtNV9/KU7AloPlZmFYTBwqEoij0ElTJfbn4OZmONvb+xFeBvY1
 p7/lMa1rrCUC1zTLGbeyGwIxbZzOjdR90JN2ygrFZLDcJ8KC2gRkxEh3MgJ7BKTVEahkj/CP+qh
 SfI4C99wPeWcrvx8wn
X-Google-Smtp-Source: AGHT+IHVECJtDixky+miVbBIW/e38Ir8CMPKzBwb6x71MPbMzbXkknYYUyXCvctLYyzIThSyUjpXoA==
X-Received: by 2002:a17:906:f586:b0:afe:e744:3058 with SMTP id
 a640c23a62f3a-b01d976d94dmr1499520566b.50.1756904881264; 
 Wed, 03 Sep 2025 06:08:01 -0700 (PDT)
Received: from [10.40.6.207] (93-51-222-138.ip268.fastwebnet.it.
 [93.51.222.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b0416842ffasm910351366b.38.2025.09.03.06.08.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Sep 2025 06:08:00 -0700 (PDT)
Message-ID: <fc0eaa0c-252e-4c74-8a2c-ddf0f3b11bb4@linaro.org>
Date: Wed, 3 Sep 2025 15:07:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/12] target/loongarch: Reduce TLB flush with
 helper_tlbwr
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20250903084827.3085911-1-maobibo@loongson.cn>
 <20250903084827.3085911-4-maobibo@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250903084827.3085911-4-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62a.google.com
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

On 9/3/25 10:48, Bibo Mao wrote:
> With function helper_tlbwr(), specified LoongArch TLB entry will be
> updated. There are two PTE pages in one TLB entry called even/odd
> pages. Supposing even/odd page is normal/none state, when odd page
> is added, TLB entry is changed as normal/normal state and even page
> keeps unchanged.
> 
> In this situation, it is not necessary to flush QEMU TLB since even
> page keep unchanged and odd page is newly changed. Here check whether
> PTE page is the same or not, TLB flush can be skipped if both are the
> same or newly added.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/tcg/tlb_helper.c | 33 ++++++++++++++++++++++++++-----
>   1 file changed, 28 insertions(+), 5 deletions(-)
> 
> diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
> index fcd03ca320..331b485b1a 100644
> --- a/target/loongarch/tcg/tlb_helper.c
> +++ b/target/loongarch/tcg/tlb_helper.c
> @@ -302,16 +302,39 @@ void helper_tlbrd(CPULoongArchState *env)
>   void helper_tlbwr(CPULoongArchState *env)
>   {
>       int index = FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, INDEX);
> +    LoongArchTLB *old, new;

Perhaps "new = { }", then ...

> +    new.tlb_misc = 0;
> +    new.tlb_entry0 = 0;
> +    new.tlb_entry1 = 0;

... this is unnecessary.

> +    fill_tlb_entry(env, &new);
> +    /* Check whether ASID/VPPN is the same */
> +    if (old->tlb_misc == new.tlb_misc) {
> +        /* Check whether both even/odd pages is the same or invalid */
> +        tlb_v0 = FIELD_EX64(old->tlb_entry0, TLBENTRY, V);
> +        tlb_v1 = FIELD_EX64(old->tlb_entry1, TLBENTRY, V);
> +        if ((!tlb_v0 || new.tlb_entry0 == old->tlb_entry0) &&
> +            (!tlb_v1 || new.tlb_entry1 == old->tlb_entry1)) {
> +            skip_inv = true;
> +        }
> +    }
> +
> +    /* flush tlb before updating the entry */
> +    if (!skip_inv) {
> +        invalidate_tlb(env, index);
> +    }
> +    old->tlb_misc = new.tlb_misc;
> +    old->tlb_entry0 = new.tlb_entry0;
> +    old->tlb_entry1 = new.tlb_entry1;

Perhaps better as "*old = new".

Anyway,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

