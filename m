Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75095C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 09:08:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7W59-000583-SF; Wed, 23 Apr 2025 05:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7W58-00057O-Uf
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:07:50 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7W56-0004ko-7H
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:07:50 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43cfdc2c8c9so34336025e9.2
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 02:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745399266; x=1746004066; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ab07izSDWa6CBpHOOCVrtYhtHxU3+gWKroLuX5uqyGs=;
 b=p9vZ4veOWra3dCnQSO9ny28hYAHWVbNkQIABrkDzG6J4AeZeP3jf2e3mmhvVHyfpNd
 MkhKjzFoIxOAIoNkvnpeci5Hh8YZzK2PxwT+uAQ9t68wbwkk7fbrKkwSgRwq8VvP3Ds7
 lZ39FpOFzAnJiA6ryhukucFJ1kikgsPadO+Guk3PphbIS4Wbq+AUTo+cofEjVBNRzXyd
 GCse+TwJ8/8SUh5yS6Q6txOZCpyCAwG2z1p87tMA5DzwfY0sMbAED9IxzU84WRbfQ8TV
 y6HFB02AVxA1478kKssQabxM2rFobELmI7gvw3AqWjKMMjMGIWclgcuSotX2/P4CvxEa
 DSiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745399266; x=1746004066;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ab07izSDWa6CBpHOOCVrtYhtHxU3+gWKroLuX5uqyGs=;
 b=CfgDHhKG4gFzkgX7ryp1rfB9jUF2hOAsyAaT/6a4u1ikNKU+gIeGuKyc8FZfxoTyGv
 CPLT78vqQ674AYwRuxde+X5X7ktR9W5xp4t6vOuCKoQi4oWM2biVWHEGtXmxQcynFDoq
 2LOyXfKlCk/EFWeXdOyQrQ1PcfgpnY6Hg9ZuDFWq1b9UWky6pLCvtuLs8hmbfTFLxISg
 NQiLudJJ3SZpZr/T4DMUr31u1Ai/wf44Badxa6qxflBMWCqutbeVqfE8ff+sW9CtloGE
 7SuH/KUbuQTeMo5vMzIp6XA++HhNQOTGljCLYWSwJPjSPB5uL7zVu5lVGBBOj/6CY1bu
 FttQ==
X-Gm-Message-State: AOJu0YxIGek3zYr9Ou6JP2RLUj01aD3X+Wiqs2L9UhOwHtXCeMd5LRk9
 1ti/vgZ5uynb8VX6vtfUSgkwK3gpSw4ddB6yuCkg1ptVk1P4hi4bdNeEbs+QKtc=
X-Gm-Gg: ASbGnctZNPrLRr5vB1oZnw9QERKCStgMjIbE7qUWSfAlfZyiw0oYx70Ksq4vpIVAr0w
 6iZWV0hGTg/sla3rlwBPYK4gerfhBOPp/rbun8iGG8ZFyH1YmK+5rHqAZCCvwin1BQUDcwhPfnS
 6Oo0aARvFJggYzQYZJjPNGM/adOW50f91Pzj2z/JmzO+TST1Wnp0DUbNfBNQ7PKK7wSv6H4U0zd
 1T6G+X0pqoMaQbQaTkIYQ8tuxXOH3Pnvx/O1VUq7820icOad1izCV2Y4HU9SntQkev68dcixswb
 qa96ti6Hu5BfEIc8tpJDIBWXnjqR1tSA6JO4LHHGeRImvC7s5L+l/wzorQ+7DezuiVUTfq84xQc
 C0RKeS6MT
X-Google-Smtp-Source: AGHT+IF5a+HNG+L+elJlW9+piPZyM9ZWA4M3Kxm+qKeQemkt683UNPe0Utu3ipT67YZTzKhNkDX34Q==
X-Received: by 2002:a05:600c:1990:b0:43c:f8fc:f686 with SMTP id
 5b1f17b1804b1-4406ab6ce61mr164032895e9.3.1745399266477; 
 Wed, 23 Apr 2025 02:07:46 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-44092d2e97dsm18522505e9.18.2025.04.23.02.07.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 02:07:45 -0700 (PDT)
Message-ID: <b0dc556f-9a7a-4163-bfcc-10be5d15e86f@linaro.org>
Date: Wed, 23 Apr 2025 11:07:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 9/9] target/loongarch: Move definition of TCG specified
 function to tcg directory
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20250423080417.3739809-1-maobibo@loongson.cn>
 <20250423080417.3739809-10-maobibo@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250423080417.3739809-10-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 23/4/25 10:04, Bibo Mao wrote:
> Function loongarch_cpu_tlb_fill() only works in TCG mode, move its
> definition from header file internals.h to file tcg/tcg_loongarch.h
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/cpu.c               | 1 +
>   target/loongarch/internals.h         | 5 -----
>   target/loongarch/tcg/tcg_loongarch.h | 4 ++++
>   3 files changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


