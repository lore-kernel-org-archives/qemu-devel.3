Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25B2FD7831C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 17:39:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIAOG-0005wn-3M; Mon, 02 Dec 2024 12:39:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIAO1-0005l1-O5
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:39:10 -0500
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIANu-0003sW-AC
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:38:59 -0500
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-46684744173so50192531cf.3
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 09:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733161137; x=1733765937; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nKwquSKWNPZ3RPpH2B60e+D5ftT8pRt22w+egVq4Am8=;
 b=L4qL/Zd6mhkJe71uXbIo3oqzukhoLiW0f9AziJgdtAe3Z90U+zVEmq1pXNbZ2pUwY0
 3adUZ84BBzAwPhaMWV2m+GaI+SXVFSn+LDPzQ9DqoZzwmfcW9cjrvj1CotNrTwrJMevA
 vlejYzWEML3EzmDfQk02c9qUdB+C+ScXkWHvl2DpuKuD4tdTrAiFPtdnGWtm8lG7GT2F
 OKjwHIlqjicyE4DlVaz7RaMKd/cZTM7H7RTgiK0ZcaiPIYmYoQc7ZC+92EniJzZAuxTU
 Mq8sHKOGfqYdt83QGJkf3EiFvY6rKyCsS3YxDTZFrpsORBlrsMnQ+8NhFWGWH5xP75b9
 EX9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733161137; x=1733765937;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nKwquSKWNPZ3RPpH2B60e+D5ftT8pRt22w+egVq4Am8=;
 b=Inr9Lyrs9T67UjZqg6/Y+83Mo45fswTKsQBUEseBwiqTmUtqWc5qN4P7fJ3S9zRu9a
 1I1BDx/heE0Db+zybSMTr7raqzqB6cPMrTLiaCxZv1UJJ884h5srhCBwLlBEuL2TMzAB
 9z6OHdMqmr9mHkirXpY8GHr8qi+lw1qtrYGNPZWkThA4uszF14nZA+rnquICsHGdynfb
 lLNWdOEwQk4qerIf+HTWQcKcyBLyWj3uF345hGSAbgKbsBSpaLaMzSJboABXu42p/CaD
 VRcHkC6FKNJnIwt6XH5RxClNHQxCiqd15znE8xCq0uL9N2xGA8nIT+iiUPZq9k4Z2zXu
 3T3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIky93XPN+fAynvvvtr9783kl5T/Sa71wg4FLaEhKaEAxECSZumYSJypamJ1SuzswOUAMncDjEpwpD@nongnu.org
X-Gm-Message-State: AOJu0YzPjSBaM0bLAalM56r3aP6zicDqa4h1Mi1hYKuOdMSw5wqSekx+
 NQ+RbMHEV6yNjx01mKusChGBuwpnvxXcEN6eCJrPN1FE4rfNTdiSYf5eyDivsu4=
X-Gm-Gg: ASbGnctHX/P3KYOnVKNN0gZEroVqUZsGbNYQFeILJ7qyQEqrB2Z5iKDJig5VSJo2rvS
 LgLTY8g0tiDTfIi5GZtVwEuAX/w6UNYGvRw1M9iuoVTl830zTLyYkSoGr0rW3neTBCNXy5jEWb+
 lENu0md9mR72S+I8/g0u6544xApbDXTvWXThQjz9lJ4DswXW1VbSXBbYKXFQoOGm3fkyvmGYhds
 SQD4KXu1Yc5KPj2SQav1plco7U20znt9sNNwcfaNUtZ7Zjs9bOER8H37Egi9AOjIxBxWs4=
X-Google-Smtp-Source: AGHT+IG7OXojSGf5H9lapUfVlgO6rjMXHOhBtL7FLagB9eh1YtO4LsaQ7nPILpX8cein9EnTPNPtsw==
X-Received: by 2002:a05:622a:118a:b0:466:86aa:efd9 with SMTP id
 d75a77b69052e-466b36bc56emr360570521cf.51.1733161136817; 
 Mon, 02 Dec 2024 09:38:56 -0800 (PST)
Received: from [192.168.170.227] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-466c421f42csm50864761cf.60.2024.12.02.09.38.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 09:38:56 -0800 (PST)
Message-ID: <0ec16ec8-4c7b-4232-a3be-e15eacc6b348@linaro.org>
Date: Mon, 2 Dec 2024 11:38:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 for-10.0 52/54] target/riscv: Set default NaN pattern
 explicitly
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20241202131347.498124-1-peter.maydell@linaro.org>
 <20241202131347.498124-53-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241202131347.498124-53-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x832.google.com
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

On 12/2/24 07:13, Peter Maydell wrote:
> Set the default NaN pattern explicitly for riscv.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/riscv/cpu.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index f219f0c3b52..80b09952e78 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1022,6 +1022,8 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
>       cs->exception_index = RISCV_EXCP_NONE;
>       env->load_res = -1;
>       set_default_nan_mode(1, &env->fp_status);
> +    /* Default NaN value: sign bit clear, frac msb set */
> +    set_float_default_nan_pattern(0b01000000, &env->fp_status);
>       env->vill = true;
>   
>   #ifndef CONFIG_USER_ONLY

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

