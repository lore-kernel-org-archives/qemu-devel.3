Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20DE7CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:04:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNg9-0007qv-2o; Sat, 30 Aug 2025 11:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us6og-0004a2-RE
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 17:39:26 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us6of-0000DN-C9
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 17:39:26 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-77238a3101fso431877b3a.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 14:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756503564; x=1757108364; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ptokQmhDOhgXJltpJ8JgLkTSP1yhe8qus+CKta6WgLM=;
 b=VqgOpH0LxwwfeZ3ZKzF463PtXxVJgT5WBXw4+ghmfEC15ZUvLz1294Hc1GaS2fsAhO
 5hwSoQWKWZHrKeFn9t0v39qY5vywuriB/rcYhmCmD4rYqtZYKAcYJpw0yn9jdN7LuMHI
 H7ldyswJxMbnDC2xP53pLKsszKqwnm4GEPLBLx7w+OcOb+oHDGLcsmB53RgwgSwLSu2u
 +q5/IEqbj7WUWn1y7arpdVBfbXxfZlXdKvfUgrnWFJBbrqETETRuWC1bkEVA9PzfS/V1
 2Nz8wrjceg1JbW2NaKOQv7CdeJI3cfNDHWI1Rj+CBGOoOC+3qLyZ2XmstlKq2z8mzFb7
 Lwew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756503564; x=1757108364;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ptokQmhDOhgXJltpJ8JgLkTSP1yhe8qus+CKta6WgLM=;
 b=MeAXh4Jy0xbCObxJUvdModAxDar/VyCdM9ugaiNQKGBgkqeI+WWvn3nJ6ysUKLKkzI
 BqZVGujeO2T7KjyY7PiqZOV4WjIq3kYIk8pnzFBWzC3zHEPS3pgD6Nk4J+K9CJWkhxNt
 I/7szsDmE04CF6RZnvJW/rWcmZhHlhpZNkwG4ULPSQPafG3Vk/U43xGfOYPyaYRuWzfR
 6CCficJ0uDp6YcF89ujcbv4Hq4aHJbTtzs/dhZAPhBVa1uwVbWLDYs/tfPAbl7kVf84K
 oqSVEVsszepAQ7YJmcUtBne0mTywPF+XCf7V3phrkw9/EWlwnso1VLGc/E/hjsGNmKoL
 HBpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLoHaIXspJncH7aQpK3qjhbT6Zvsw5ze1khp+0Mp5YvwzcAZZT2fem2Mh3/fRl58qDlHjY7RKnvT1N@nongnu.org
X-Gm-Message-State: AOJu0YxswvvwSdbT/tjlN5cgda8i6gd2RIX3UYPXTI5JuvCdKdVrpYSM
 V6jlmm58KOwgXdv/pn4jGXa7rlr6E+wf8DdRIFUxK13RMUkJALRItHE9qSsQize3hoM=
X-Gm-Gg: ASbGncvQ1/0RYntTXFjdk8NjnsWnuWdojxtv5IPnuePGqQovJDZabJL6SA2T3QaZWNz
 4av633yu5SL6Kf1UicKm2cq8yCZ4Q8+Hr8J6UY0lpm98DTiwVk6Mqv0+8/pRZg2AnnTtDiL52vJ
 4dCqMxGYaA2nVmpAvxFT3JyTy6av5moKzN6krZWipafJQqNx9uleLm0WL8909WQKQ9jTasuiuOZ
 Gw3ktgkMBQIWmHG+JCOaM7dh1FXZfIXwCrwedZEBDRcNIERP6jVLsoyJ858NX8QXvCa76R36EiP
 H0zTG9YMXAJhOSIb+Zg59ZzjStr61Oks1cZjkxeFgoDKmVahNZ4RXoXouAR1WFYPAXb6T09s2FY
 AMhmXzsdGzuFTSgkU9OgV5sBJc3WphUAhWcUYRbmpwFxRsBAf4RAeE1GrbphoZXrki5kPQfa/mS
 huvbwi
X-Google-Smtp-Source: AGHT+IF6FR6QFRpb2C0NsvXLzQ10YQHBP6JGnq/MG7SqYniaRxmc2NA8LyJfZDJjzWPel5nNO9t+kg==
X-Received: by 2002:a05:6a00:39a9:b0:771:58e:5b10 with SMTP id
 d2e1a72fcca58-7723e2534acmr122976b3a.8.1756503563780; 
 Fri, 29 Aug 2025 14:39:23 -0700 (PDT)
Received: from [10.118.1.198] (122-150-204-48.dyn.ip.vocus.au.
 [122.150.204.48]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77232248100sm2269195b3a.98.2025.08.29.14.39.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Aug 2025 14:39:23 -0700 (PDT)
Message-ID: <340e9737-c31d-4c25-9e93-be22641251e0@linaro.org>
Date: Sat, 30 Aug 2025 07:39:18 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/18] cpus: document that qemu_cpu_kick() can be used for
 BQL-less operation
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, imammedo@redhat.com
References: <20250829152909.1589668-1-pbonzini@redhat.com>
 <20250829153115.1590048-4-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250829153115.1590048-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 8/30/25 01:31, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   include/hw/core/cpu.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 23bd02277f4..8b57bcd92c9 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -829,7 +829,8 @@ bool qemu_cpu_is_self(CPUState *cpu);
>    * qemu_cpu_kick:
>    * @cpu: The vCPU to kick.
>    *
> - * Kicks @cpu's thread.
> + * Kicks @cpu's thread to exit the accelerator.  For accelerators that
> + * can do that, the target vCPU thread will try not to take the BQL.
>    */
>   void qemu_cpu_kick(CPUState *cpu);
>   

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

