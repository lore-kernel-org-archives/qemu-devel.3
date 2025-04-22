Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4974EC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 16:33:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7GYv-00074W-Ex; Tue, 22 Apr 2025 12:33:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7GYq-00073v-QQ
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 12:33:29 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7GYp-0008Uh-1b
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 12:33:28 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a064a3e143so485442f8f.3
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 09:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745339605; x=1745944405; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dakBj1vycfjaqvrEDSThMv32DURaF5EuHVfNMCyqZic=;
 b=nWKqAZs3ezHOrNbuyLG+Ak5EH8KQ3Mks/0dlW60cBgBvH3JfYesl4weNWX8Tyr9+/W
 sR4W0lkohA1ck/BcLSlDwUcRuGnQuqDvNLm2bzCTnX7ZYHYx4KOfFQR+B4V/tahpxt9V
 x09fXrkCxRQ5lP8N79q38sHNGAZfVgVUqqY+6i3U6kjuv8fiiqE7peGJaQK1x8tRA3YN
 MxS+qkqnCeKyMwPL95mj9vyT6soxoRFGt7J8Ozca2eQPWWkysSSuLceb2gbchUrGv6yR
 crsrOZrYRIjgN+lpjJpXR3OHsYpZwTkN3HBhMiOZwtrDgM41fvY4Ardr68ZUL4+KWWSs
 tEqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745339605; x=1745944405;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dakBj1vycfjaqvrEDSThMv32DURaF5EuHVfNMCyqZic=;
 b=TNSP+3WXHm6FsbFL4VR+yw+uH0Zj2wbEMdBMZ1bImMN4dFboK0v5a076UHqTdKJks2
 YIcZZ9LCBzEMDkURBRkCEmjf2dSpXHiqbmsc4zuDAQxB9uqN/4mH5IWOZ9yswOtlM3fP
 iwEU/H9z8t30CxWnCqTWjGC9k6j/JldjitZKw+e2hbgwAw/VCjCxV9yOKcYzk0ToJ7w2
 UlvarxPn0NITBiPjzvwazJC1DCnTA4N0r4cUZW1buKND7DXUXM6tUxvJUSiVK4FYg8ty
 N3wLdAIoaJjkFrQfSHVujn8MlITfYKawx9ok5/rPjwUdFaLC+2k8unKCeGpZvl2HZL/p
 PiQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCxdVXmqby28160D7GTP8ge0ncUVua0+1nJHoqW0701xusJ8FaTgDNDJAogTl/uqvCReDzVA4uZ8eU@nongnu.org
X-Gm-Message-State: AOJu0YxW8Aq7uICDiFTglh0IRUo3shZr91FrtrhZTEq2fKxPaqdINbaL
 pkNZoBxmNBZLrwT9e5tAZol3R0k6H1ifKDXb59mtbKiqXbozNkbBVgmh8ErA3UQ=
X-Gm-Gg: ASbGnctDYxP0F9j68TnRIgpF/tA7eueibC0NaqfJaX6PWHIhTBBq7enAVhawfBApmCC
 XjXTK9rUiHCLufw+XhowI/VAbauvRaQkfD4KV6qb5+7tJ/wW0jqtbfEf3J0FqOnPrFtvV9MMVpe
 dC88j5He3bpYkGxh8sVFOblpG8fo5unqORS+TLCUS8E3WX3fUCPWcOWjxaUyG0ge6IfNAeraXTy
 OckgKLc7uAZTCmYAr4SgSlNhPs4GHLLIKP2ixyzSk5CWYlbuVHPU6kluor4YyraxVH/6mH0og8A
 xZnB/kAlDj2XnIH/YpWhmP98W5HLLds+PWLlpFKpYd+2TDEtQuulvjusQD9BGixFMe7w77HKvKF
 5e7DVJyZ6yrKv+eY9TqY=
X-Google-Smtp-Source: AGHT+IGUX4qailQdWB5e4Gb4OuzaPg8fLJd0H/7kJN5faNu72vBLfjIkOtBpDASD0BLsBtbvAjrzLg==
X-Received: by 2002:a05:6000:2905:b0:390:f460:77b0 with SMTP id
 ffacd0b85a97d-39efba5bfe5mr12469031f8f.26.1745339605189; 
 Tue, 22 Apr 2025 09:33:25 -0700 (PDT)
Received: from [192.168.69.175] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa43ce6bsm15890220f8f.55.2025.04.22.09.33.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 09:33:24 -0700 (PDT)
Message-ID: <d2e719e3-ecaa-49b9-b58f-449cddf19d7c@linaro.org>
Date: Tue, 22 Apr 2025 18:33:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 128/163] target/ppc: Use tcg_gen_addcio_tl for ADD and
 SUBF
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-129-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250415192515.232910-129-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 15/4/25 21:24, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/ppc/translate.c | 11 ++++-------
>   1 file changed, 4 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


