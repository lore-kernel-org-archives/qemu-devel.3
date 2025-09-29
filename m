Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56167CAC5BD
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 23:02:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Msj-0000R0-SG; Mon, 29 Sep 2025 19:02:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v3Msi-0000Qj-Gq
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 19:02:08 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v3Msc-0006mT-T8
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 19:02:08 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-77f1f29a551so6987594b3a.3
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 16:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759186920; x=1759791720; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hIKUG78DwsPPugwCj004d3vQis5ZKS3dyYq6AzvHlYs=;
 b=FIP5uBs5iyiRFZJJAqY1PNActmii2uZDe18oGo0IiGSAzCiDu7M7UR37GY8EZO7p01
 twob4LUKXe/pxFU8cADacbI623q71uE0LLzRscfdRjaBpaMF17lHoRyVYM9CIrfF7Mff
 sDIpfrPnQOyAfFYttAQDXph9acLdKSgQPfk/ODWpzc7Tvx3feZH/vEZLj6QTEEYUcVDb
 BRYe2LhwvQcWMaeSEXryOJNt++garP5d+ctGW06HMmI+uMpPJ0vtlkU36GwkntNQK61/
 QoVkMFKsxw38WX8K1GLyZl+1yKUAX9UhrHSoTVnbl7eBHhMv9plkiNLZDBIDGACeZkXz
 EM2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759186920; x=1759791720;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hIKUG78DwsPPugwCj004d3vQis5ZKS3dyYq6AzvHlYs=;
 b=K2jVSPJ4u6/vB616NCkh5Rwej626nvWgu0bS3R4qEYMYw3NICxtx7JcvBCs4RI6pKJ
 Ajs4X2BFekUOsrU6ucI3qKWuy3dr9lzFSDPJCpZviP/M93Dkhh+ZR4vD9MLhAV1OJoZu
 QVIB+KtwJoDIHOkEhcXdauHAwz7XvxByyfgkd5feVwttb+4oKj3x5FyiX+OYT4225kKF
 b/+OVELalgKg0lfFAwxh2itjGyolyL/7hMBbDdsj6jHwi9YN0K/cwLwFkneFYNunpEKh
 NwiIEMgHndVrIyCLq/bV3GWPDS/UtVgtE2LLLFvc1r3iSNG67k9psR0lEj8MjvZ2p6O6
 cyew==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/IV7+VT7f8zq7Z2CbMMZvQRAVX875NVpokAhCFvdaOeP15lVQNq8ebOgiOAUFIQ97TLfhTofwMLfa@nongnu.org
X-Gm-Message-State: AOJu0YxhIHvbhHq5L7cxGcSVmsEuhrDm2W9YOiJrzA6Z/ImUnEQeE8eK
 c2/Bdoz5uud1/njt/slzUlj1phLOsybYEikuX0pCjmVHvA8w954XCwD2xYW2tMGYmnk=
X-Gm-Gg: ASbGncvv9rQLUqwNSf7lM1dj4A66Fc+SPEoxMn+qqmPzq9jMt+Uz+mbK908N2TB3IHA
 YWTr/+3YY23W/tx8ReVani0fTqxTmH/+Z+44JeeT8Uee57bq6DbfOuGwmY6VmCkWqVpDtjgs5//
 oGpmaHOKUNu99T5f+v9NBO6ZGG8GQcBcw0aenQ5NQTaWEDDE0AvG/PU0+18XjXouHuWmQoi7Sdg
 VExQet1lcq29LjXa/MflzU5NY3xZCFI45HP88+GDQZjFOZnZ2ynpPtAAvJ/m/hxoUpk9G+5Svg3
 PZSkxb/9G3uEyODzUkWGpp/I/y7ArdXPbJyaxTmgupVjs0ttiQ67d0IYmbPw/HVSryNvL+zQzf4
 i7+54gct743KiKnaM/Lper5qwzbVTHOzYvTggOmA3Cr0fmQ==
X-Google-Smtp-Source: AGHT+IEre11r6B+GrO1kugHORRpSepVwnRVqs4B7j7Si5gAUc2Fru/PV4TJdhWxYDZsS5fvSpe2oRA==
X-Received: by 2002:a05:6a00:b85:b0:772:40ba:61c0 with SMTP id
 d2e1a72fcca58-780fcdfd87bmr17173669b3a.5.1759186919985; 
 Mon, 29 Sep 2025 16:01:59 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-78102b2865bsm12213527b3a.64.2025.09.29.16.01.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Sep 2025 16:01:59 -0700 (PDT)
Message-ID: <b2fb81c8-3a5f-4187-83d5-eace6fd204e6@linaro.org>
Date: Mon, 29 Sep 2025 16:01:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] target/arm: Add GPCCR fields from ARM revision L.b
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250926001134.295547-1-richard.henderson@linaro.org>
 <20250926001134.295547-3-richard.henderson@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250926001134.295547-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/25/25 5:11 PM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpu.h | 6 ++++++
>   1 file changed, 6 insertions(+)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


