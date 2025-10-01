Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CB9CCCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 14:32:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3xrS-0006so-1p; Wed, 01 Oct 2025 10:31:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3xrH-0006r1-Bu
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 10:31:08 -0400
Received: from mail-qk1-x736.google.com ([2607:f8b0:4864:20::736])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3xrB-00082B-T6
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 10:31:07 -0400
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-855d525cd00so966606185a.2
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 07:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759329056; x=1759933856; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SqH3/lE6ZwKEgJWoWzFCA9aeuqXc3ZhKttWqq6rbPmA=;
 b=Dzv1m3yHEIrORHbPo5ZApXpCz6JEEoRvG1UtcJUON2Cl8WJPlh1dlnJsSMYPxhAtnW
 rNBnOxI6hCl2dTBXAp/Ld7MJUAaet2Eaq7VSumaE71JU7DMozt/L1HsZLcP9XP/Bdqi4
 Nhi5R87Jkg0LLfbKe+1oRamULT5o/J2jyAfgzd6FD5oq8OIETPmFql60yfnLq7OWEpqe
 OaQjM8OJYdDVbFzp45j0Q1ll14NR9hiZ4PCDwF0ge2cQS5mUkXT2dLZH+hWCGJvhpvgp
 KBH5ChtIckFrenaVOI2EoejnbqvNi6X9mOHXR3sOiF2CKlRuHosvdzS+2B98JB9ED2uJ
 riQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759329056; x=1759933856;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SqH3/lE6ZwKEgJWoWzFCA9aeuqXc3ZhKttWqq6rbPmA=;
 b=VRNAIthetqwkWsKCaVra4Ckr/H7vNoPrCoqjA9cvCPZZQlI4fg1WugQujohBc9/frH
 rL9hcZnZfmQel4N9R0Gm0qVAjlmxwy3dP9u99yhVRp71z7xj+eqkhcGZlmuFXi+b1b+g
 Z9X5vDe9sFHd7dlZsaynU23M+CGfYOWDOSCGXkgKd5S9sEydNMylO2ump//luonTvHoK
 Wnl2CLu1aAEjmoXqpjOi/6DalNYf/4CVb+pA53+6s/FWQGTWG4Oak5lzqzaDNQNsV9nj
 9tgCIJRO78fTkpUWA5DwIP4478ugX8AHmV7QT1nVn7ptB0oVR6E4gcuxDeHRZSDW8wrz
 KJJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/LL+iK6B3KUPenQtD+lQaeodWi+43/aax1kaWBoi+q6qsJE8uop/h27uxddd6a2uQ4RyQLtUuc4Ao@nongnu.org
X-Gm-Message-State: AOJu0YwJ5vxFLLCalfVbxTucI8l6+PMcNNIUmQjjKqusQ+xorII/8N6D
 Jq5dYUxK43h5AjlfLoCyulkqUBKw0PECdQVBZf4avgenSEULa2fwX6skhxt846lUNZg=
X-Gm-Gg: ASbGncsyNJ4M3c+w7Cb7VeykRKFRdKVla3+ygJ3xt2uRSqZ/Lgl+6h6omrEn29TQwte
 SoLfeY9MaE5012oeGo2810rOaWsMZRVzCugjlvEDyZbY984QPIK+LYQouAnBvJXI2Fo0VOIJuhi
 l9w1jx6MZgpOtuGBjqcKN0Hsr8k+8fgK6KwqGOXnCCHW5lwJ9abUa+Wlke8vlZiy4iRS841vt1p
 Ue+tBth0Wb3Z7+8fNlxQlSNxvB3XkIyVKBX9cZXfoNHgvWrGZrmPIY5yRm0Hk+hVRST0LBKCU7B
 Tt/Wn8qZ9O9IDgXVxUfPA8XzuFbRTpZK21PyxlgaRqOLqVXLsrOqVFAbNAyyJylhKHS1PtJVKfA
 nrELcY1Wpb/6tJQhln2S54ONu+STU8NmHC1/Gxb70qyuIE1OMwrSCkeHXn9Y1P288HbFWMIJlu8
 IPZdWLmOM0xJlYvCmVjnrPRvWxf6RGVkaASVGUv4JcBA==
X-Google-Smtp-Source: AGHT+IH5CRHxy9OP0UhKNClMF4nGu2IsX50wZZXSDWEyGiPOzrgzX1mybrhJ42u2HOv9sMNQmKttbw==
X-Received: by 2002:a05:620a:1a22:b0:85d:3c32:c404 with SMTP id
 af79cd13be357-87377433efamr453188485a.85.1759329055600; 
 Wed, 01 Oct 2025 07:30:55 -0700 (PDT)
Received: from ?IPV6:2607:fb91:1ec5:27b9:1bec:2e21:cc45:2345?
 ([2607:fb91:1ec5:27b9:1bec:2e21:cc45:2345])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-85c304ca920sm1214873285a.33.2025.10.01.07.30.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 07:30:55 -0700 (PDT)
Message-ID: <ce295cf9-fbac-477b-a2c6-18f0b23f03a1@linaro.org>
Date: Wed, 1 Oct 2025 07:30:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/25] accel/kvm: Include missing 'exec/target_page.h'
 header
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20251001082127.65741-1-philmd@linaro.org>
 <20251001082127.65741-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251001082127.65741-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::736;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x736.google.com
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

On 10/1/25 01:21, Philippe Mathieu-Daudé wrote:
> The "exec/target_page.h" header is indirectly pulled from
> "system/ram_addr.h". Include it explicitly, in order to
> avoid unrelated issues when refactoring "system/ram_addr.h":
> 
>    accel/kvm/kvm-all.c: In function ‘kvm_init’:
>    accel/kvm/kvm-all.c:2636:12: error: ‘TARGET_PAGE_SIZE’ undeclared (first use in this function); did you mean ‘TARGET_PAGE_BITS’?
>     2636 |     assert(TARGET_PAGE_SIZE <= qemu_real_host_page_size());
>          |            ^~~~~~~~~~~~~~~~
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/kvm/kvm-all.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

