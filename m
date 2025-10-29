Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 619C6CCF9E9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 08:01:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE174-0002XZ-AC; Wed, 29 Oct 2025 04:01:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vE16o-0002Pw-87
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 04:00:49 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vE16l-0003B3-LV
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 04:00:41 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-63c09ff13aeso12027126a12.0
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 01:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761724837; x=1762329637; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ql5bKAxaYAKUxX0VLJd7feZr+XAxbQxLPmdw2hRi2xs=;
 b=mCIwlQfADR/Abn4YzZuATM4MboegB7z1xvZW+8BZM0skIfjSKtE1ki3h4nUaOlYb8g
 ysT0rgMvkno11+7GApH0ztBnZs4d+K2A5KutquSQWiNV5b/A/MbLQprAwq7vJbWVFVv2
 OOEJSmwx4EyFYy9BZokbAaMGzpd46oz1i1GIFM5WgW0WSQIDNGGbrogyCYgDQd7UQs14
 LKGNLvh6JmYbjBC3fmiOHhagRdi/ykrGEo0dwY+5lZokKD1gIIYu3D01jFJLuVLPQS7/
 u4KuOJJAf8yg1o6/SAd6wwtWg8VZlmN1Vcbcm3I32gq156wqw0sNSxEqIzh5hS8rxzzi
 RogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761724837; x=1762329637;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ql5bKAxaYAKUxX0VLJd7feZr+XAxbQxLPmdw2hRi2xs=;
 b=rmMiOgbuoYMxSs4LsbW/ry0CGUyFQbaxltaFyX0mf8Y+Xwbduvo2RvL2EnSnTEHFJP
 9Ag46BENvB+dxbmHNzvISr3su4jjbJOofSoq0GzcW91O5evHmLtBcgU9URsQaQHdAbF5
 RE7a16DF3Rpui0FcgLkHF9riqgbW/Aq5tveO+tf1M/KhraaIAm6Ier1JGJVblAG/YrPK
 rSZIZ3eEGauoYa6OofWBrI3srbVpwlaL3jnmNt2jFWpK6qDwmqBfopjCrwgSg/DkHYj4
 ajbDrVQLEGQ9tnFP2Zm4i2GqhJoz3QBH7c1mlZ8kSPV7yrNmR65yUARL1V2nTkpDwXgV
 2Mmw==
X-Gm-Message-State: AOJu0Yw9s5K0dmAuOC4lcWeqaisoqfcNwSIMsTSl5r10gFL+A2KdWS8X
 o+nuFJQwmeQZJdXXN31hN3KuJ0U335KsNflIFYHENTrG+t9oDIKzVgufYNoIz4NidEu7SlLO/6X
 ESjltclM=
X-Gm-Gg: ASbGncu7/5ufQJAb/EZuUrYw//fntBuLIOR31Hi+FqfENwsmQfWT9YmjWXcc/y8I3x3
 nekNZ7Rsg4E8buHB7aZWyrvVvSe8wNnNw1TZPVzYcTkPFPSsLIW9KlT2qxJea0GUyXHVqGUJpqS
 fYVk7T+C2BWvKaZ/C5VW5nujC/PQ0Z1Fmlez9rfU9/ekPTvnlVkiy1i6bi3/kLKa7DrUb1llWzY
 jT0U2biwtTbOJwfeXAQvd3eyofc17TM5obvhH8pvNLaG7OGinuB4KgUJGuooRKmw+s71PQDsJoU
 fRd6HNNK02LLQd/QH65ZoLfwLWPKKiBCDa7fIzwGJIWz92Kc4A/24PY07j24b0D47sEsUAxZWv2
 o/PcLp3F0ZplVhsP2ugiBs2RowrQvZogxpAK5mDQYaR+6LVGvGlpleig3Gs2I7ZNU4AYI3eNBa0
 ADSx+hJ71UpuaeKDVU
X-Google-Smtp-Source: AGHT+IGgBO3776x/LoHhySaHhlUzn6c5TeNBzHBZeoJIzQ0K01AGLk7VmTC51MnFlAmvDKjlixpi0g==
X-Received: by 2002:a17:907:c03:b0:b3b:9832:f9b with SMTP id
 a640c23a62f3a-b703d303048mr208758766b.25.1761724837488; 
 Wed, 29 Oct 2025 01:00:37 -0700 (PDT)
Received: from [10.240.88.227] ([212.144.248.67])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d8541f95csm1354093666b.58.2025.10.29.01.00.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Oct 2025 01:00:37 -0700 (PDT)
Message-ID: <e397a39d-132b-42dd-824c-413223153070@linaro.org>
Date: Wed, 29 Oct 2025 09:00:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/25] system/memory: Have memory_region_size() take a
 const argument
To: qemu-devel@nongnu.org
References: <20251028181300.41475-1-philmd@linaro.org>
 <20251028181300.41475-11-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251028181300.41475-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x52b.google.com
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

On 10/28/25 19:12, Philippe Mathieu-Daudé wrote:
> Since the @mr argument is not modified, it can be const.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/system/memory.h | 2 +-
>   system/memory.c         | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

