Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69CB6C02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 18:05:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYUEb-0003Ob-MV; Thu, 16 Jan 2025 13:04:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYUEX-00032z-1Q
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 13:04:47 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYUEV-00075D-DU
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 13:04:44 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-21680814d42so19820485ad.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 10:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737050681; x=1737655481; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bu2iA/Sfuwpuh3x+B+8+tvoeiW+vCVk5vldzDF/qJWE=;
 b=lPWKnBdmx9NL3VMvZhWHqy+LWL1eb5GTf0O3tZf/IYtbpOa2ofhkzZkbAQkTSSwvdO
 RvudShxwr++9U74l1WepP99lkoRi3pYcbAEtbNXEEoqac80U2Zq3IirqyOzaav8iMW60
 7lNRSi3UxX1n2CoEAK4P5BFLgH2PACZVm9hkplU0aQf3eyz0CwkRzyfn4Ip96QepBodI
 mP14xoxjcS4KK/cqj3gGznwQ70SC5ObB0bSQB9lmDoG1O1wJK6OYswG2JxDc9GE8gdY3
 uMgxdQKchpnLvUlkr5r7eCuI6DK53LLnBEYF8xszurJhJIzQq3DWDk2Wyb7ZgrZ+Z+wj
 5gFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737050681; x=1737655481;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bu2iA/Sfuwpuh3x+B+8+tvoeiW+vCVk5vldzDF/qJWE=;
 b=Gn5nyS12q3gLKqPOpB0cnUUsyO9Q8rt7KIy5iU3sJwenryvUjRAG/tV333fdCj4qjV
 4Alra6RF3lGDA7gOuOW8wntYkUEMNZmjnIwLZU0fd6ZwoaElh+k8kBIvCj9HfeFuTvUZ
 xwqWVPCLRrMyqIaszowl3Y3yJ+e0KZtNKNN8+XZLAYFunPxglcmY9XyIjXviPRKSv3kf
 CdX0F8ADwti2jkpKr/FrYm/xaRAgcTOT83L4yalTxMgQIhIeHLi1y8+Tvz8nP4m5G3f3
 DDlu2jSbC5/hh0cty4ssp1pWfGfEf4lz/ZmZT6SLGX8CpV3f/4mr4X17SwkLbAfCsCL+
 xFhg==
X-Gm-Message-State: AOJu0YwqF1DSeSmlt6NGV1TS3eoF52K1POR0WwHX+eOQuz1z6czZkTSp
 IpFE7DmXaBV+94dFa8MV5tLdzDHsXYs4vQ7BBZsJmuEFOZNlZ2hV0LpsL4sfUwJVHSKCDuZsox6
 m
X-Gm-Gg: ASbGncuMupSaiHkB3Toj54M7bIstF7YoOfxbZzIAZ3kqplOTQZypR7BrK4YTCpXOV4r
 o1pg60BahoOzWJ9APfmL0jFa7WdRgqetQn8o8R2tHUw2KLdprzMdGcIC7Y+GbMOfSSvT+C6GB3K
 1vCJwpaxaQHB1eUN5pwJljhKtfT7j0f0nGAqE8kM7WwRu7GqN17iqBqtV/JrRkFVXLDJsW6KfkI
 2QfuvdCi4Vbo1tyIANRXPsLgQH02m+6JqjJ8NrjuxiHgc0KaAfvfF8TvGvieHXwE5oEu/P6j26C
 Pw8foblWZkh3pYV5Rm+YEls=
X-Google-Smtp-Source: AGHT+IFqCQ3D1R0XFm4QCVeYb29xmR4FqfB5Tr7ijzD7O/QAdCqNb7cT5LlJo6dyu1aNYCXIhaGwFA==
X-Received: by 2002:a17:903:2b10:b0:216:325f:6f2b with SMTP id
 d9443c01a7336-21a83f54ef1mr573309895ad.21.1737050681238; 
 Thu, 16 Jan 2025 10:04:41 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2cea2666sm3036205ad.25.2025.01.16.10.04.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 10:04:40 -0800 (PST)
Message-ID: <abb71378-df56-4bdf-854b-1bd36f25acb7@linaro.org>
Date: Thu, 16 Jan 2025 10:04:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v2 13/13] hw/arm/virt: Remove
 VirtMachineClass::no_highmem_ecam field
To: qemu-devel@nongnu.org
References: <20250116145944.38028-1-philmd@linaro.org>
 <20250116145944.38028-14-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250116145944.38028-14-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 1/16/25 06:59, Philippe Mathieu-Daudé wrote:
> The VirtMachineClass::no_highmem_ecam field was only
> used by virt-2.12 machine, which got removed. Remove it
> and simplify virt_instance_init().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>   include/hw/arm/virt.h | 1 -
>   hw/arm/virt.c         | 2 +-
>   2 files changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

