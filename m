Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C627D70DE9
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 17:55:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGijH-0002HR-HO; Thu, 28 Nov 2024 12:55:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGij3-0002Ei-R7
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 12:54:53 -0500
Received: from mail-qv1-xf33.google.com ([2607:f8b0:4864:20::f33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGij1-0005UC-Ln
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 12:54:48 -0500
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6d882699271so343176d6.1
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 09:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732816485; x=1733421285; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=amyzT4C0uKpVuwCHXukCFWEMz/fRNnJpM9RjlD+hmOM=;
 b=uOcNczHJbfKzYZDyGq2s/3qSEsse89oKDfS2ZMj9AH3Jyu6gGd0WoqkkT3hWFRX9kP
 IcyBvCiF1bVBeIAoaX0oW5l6LqG0UJlUXZz4X/JjpGYk4lA4TFkifgP+TgkwbO7vw9+e
 lbEy2EMxzgx834fh5NJupKvs+VoV54HG7Sx4m3ixyyJ0aeVTxelQU7pCm0wHhCIZz0Aw
 DqBsbll7B/OaDjuPXPxEUT2me7RpW/G4rhsf0QuQiHZkTPM0rF9JjyAgUkGVzM4qwmKZ
 aV4Qtl7ANd4dNmDMyhi98u+RE+vnq5EZqkCQhJAjgvALHag+jhqTnSKiKl1s45daIw6y
 Z5fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732816485; x=1733421285;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=amyzT4C0uKpVuwCHXukCFWEMz/fRNnJpM9RjlD+hmOM=;
 b=TwxzLVFI4eh9l8Vb5ND7xzfyB4naKOHeBIygRLbPajP39+Y+3SCN4X5VB7pFhGjmnB
 Ys7GubPag5AwgxYXf9SJoDjNuUcwRa0Fag0oeRDxZnswAufrIPbt3OjjR7GfX7gwOGah
 yzL0Tbj8t6QOH+rxnJyLe8PM1Kyh5Dnt6sQkPS7mzRyufVJWXw4pFGahVDKlVHPSIF0x
 +LjIHhFpLHppyzX5xenzleplih5LRqutB2KppCxtPEapDK5KCauA7LpfRhX42G5M4kxk
 o5AnJlo+0wY91imUeu3GCeaIm2ii6kiG4OBSHJGKxYxXzR8n0fsh5fNh4nD4tW41NJCT
 OD6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOBJbC0FLPk9a0chTkSyQHMeGNpT5HFBOUV5IZGLCWxM+KYBMQuvp8j2top9p9BPMoVKyKIEPgKT++@nongnu.org
X-Gm-Message-State: AOJu0Yyz/Zdl+F1Q7eYf4s6ASBGipFNfmiFQZki3NCWYXTYuvqG9q4vz
 tTHved1cOlc/xvFl5MbFfp914YbtFgIpBDUD/i5I+RJc4ItYqSK+HM6dMoQ97AI/k6G6P8fkzzs
 99to=
X-Gm-Gg: ASbGnctSkZkhln+T5gqppT/sTG6GkHwyAxKXOb8VIkbzghuRP1qqjWZLlHLxFb9Ma0c
 oIFp1H4EQYI7ahqwNisKJcR/qIdzHMTm+7GNA3X5JAkNfQjFRvKAYwxyuiyfXs0at2ELiga3nnt
 fJUNDgtVjoncrAJuPmstKBVRw+G5jfeVSlvRwJKzjHiS1F2vpu30W15J40RZpl8XVMhDMxJ+iTZ
 X89p2kCw5dUv/fJL9QsEg8gC5qslNTjV12gb1lSYOck8s7Ezske5qPr6uMGpEF+O0w=
X-Google-Smtp-Source: AGHT+IHAiNFFkgV29691jWbqjJ5iGq0mUCCJIf4O2fN8k0UbASobxObIMNQ7SqUJKbAZDc3QdY5/XA==
X-Received: by 2002:a05:6214:27c1:b0:6d4:254f:1c8e with SMTP id
 6a1803df08f44-6d864d9421cmr115493926d6.37.1732816485370; 
 Thu, 28 Nov 2024 09:54:45 -0800 (PST)
Received: from [172.20.3.167] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8751635ebsm8537456d6.22.2024.11.28.09.54.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Nov 2024 09:54:44 -0800 (PST)
Message-ID: <53178bb1-404e-482c-a0c0-6c0634cec043@linaro.org>
Date: Thu, 28 Nov 2024 11:54:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.0 21/25] target/mips: Set Float3NaNPropRule
 explicitly
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20241128104310.3452934-1-peter.maydell@linaro.org>
 <20241128104310.3452934-22-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241128104310.3452934-22-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f33;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf33.google.com
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

On 11/28/24 04:43, Peter Maydell wrote:
> Set the Float3NaNPropRule explicitly for Arm, and remove the
> ifdef from pickNaNMulAdd().
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/mips/fpu_helper.h       | 4 ++++
>   target/mips/msa.c              | 3 +++
>   fpu/softfloat-specialize.c.inc | 8 +-------
>   3 files changed, 8 insertions(+), 7 deletions(-)

Yay.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

