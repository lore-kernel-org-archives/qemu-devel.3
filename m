Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C06CCCF9E3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 11:17:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIPtR-0008MF-PI; Mon, 10 Nov 2025 06:17:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vIPYh-0005oA-HD
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 05:55:43 -0500
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vIPYd-0001gX-Gr
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 05:55:38 -0500
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-44fa4808c15so356622b6e.3
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 02:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762772132; x=1763376932; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SFyiQnZ+wHzrtBWZ0LzKsIkHvY79oMBVulmthLwF0Wo=;
 b=A2yCJmr24A1JXQt5zOob5ppLDpsrrA9CKcPOe0TalicS2NrXJIT3CvhVdm6PKnKLh4
 FEo/yIGWMwWce5zZIcyHARi/QtnX2s+S2Niwh24DipOtyAY6wGDyTCxqsPoPg0Y+XW4G
 TfsML911OZAGNf5VMxoH9mTllkDAMIs0546xotnd8IM1JKQ2jYUUlm1IRTinMZlSlkjg
 ENsZWaVQq8hqBFHsmjhJz8wR1tRCFNarkZm1phzxXalWuKfWRZV7pp2AsF4OYOCwW3EE
 rEbQiDzmF69aPnknCzxj8MR2Wl/t3HrodYRbUSS/PTXQRMx4VYdV8dZsvSflimhQwT/S
 7sKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762772132; x=1763376932;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SFyiQnZ+wHzrtBWZ0LzKsIkHvY79oMBVulmthLwF0Wo=;
 b=GXTHxWtxcDFzbEeK4MPU5uAI9wcKUmOBLVKVrmqNy3/vkRrhb7uY4JsBIxwU5erayu
 J5PgJzEDvZAKAq5MarQcIl2YV95lN9uK+FAgGdkEprlhs1QbeboeZKHNUSHVcifCpLEo
 OlJYujssMK7rgu9bHSiaa0CQEBW8wCGH4iaUHsLVAkBxM6+3U4JWn6kHhbMfNbbDZcni
 DN9KKZGtxgD5vNglcc0HJ21t4jL2qd0IUpzftEjsWD1Hvf7Pq69XcXHaqcf3ztvrnU8X
 J7+7BbzlGEx93WoGUhYxGLW0ebiWCVG5HmR3cKIE/8NYf68AxhHSQvlKeNSxU3z/4k6W
 4Ytw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLhoDtVHeIeA9OuwbzN4F7srlWItFy4HP3WNY56SyAUQ98dOsJrB3EqhV2peHPMgmFVZAVdmvqxzNt@nongnu.org
X-Gm-Message-State: AOJu0Yznn0R+xb9IE5YMuIm/1EH1ePKXT+iQ465mBdGdgzSx0fRkIwGP
 93JJ1yOpTWlVivHrwitJyU9L8wow8vLis3IBS8oWxD21vSZWvtxmXV1m1Zsn5+BoBEQ=
X-Gm-Gg: ASbGnctS0Z5RM2TGZnPRNPtiCucaM+hKv2Auy7oW0AQ0lFT1mcudCBoYgaKJoRz4+M4
 wqBZt09upamADm51OONH2jVPQRdiPcGYkN1vTepdR3P0abjTlCw2//1aK2q3HaNibLkoCPCpNsW
 Sw/imENgXkCIZVosGIW/fdmz0ySLk5Vj9hZNh5dme42KZ6oBpwDeDXmrmbS/tUrSGbetjq2IisU
 V1dh92X8/sczC/uQKX0E3DJ62UPm7elaF2yNKhOrA7E7yOGC+xUAAx+Q9tcxTLp1PdiN13ExOXJ
 GCdw2pk8CgWnJg93vTQi7EbhM8q/dFPY4g7Bm7ehXJwe+i5t8xnQoGqjgp4XmuYAbR466WuWHEy
 1PmQm7a6dWtiiPMAGdYfzzIwHDHMo4mohKjRUaLeYJjKsbt8nA89gCPjktfg9SD0g3Y33pqWFp0
 HdWXFfm5sLZf2M/KuieTq+rQ2xi82uoF7T0zRHMBjYB5kVI6e4UBYibesYS7vz6h6oz9B8iy1H2
 awToQ==
X-Google-Smtp-Source: AGHT+IGzJYh2luVQofzfPpVpmmKm6JwP04SHpnPkEsq17X2lxiwpS0dwbCB6aIQvAw6gDAf9iPHzMg==
X-Received: by 2002:a05:6808:2187:b0:44f:e7bd:274b with SMTP id
 5614622812f47-4502a3f8186mr4557731b6e.55.1762772132649; 
 Mon, 10 Nov 2025 02:55:32 -0800 (PST)
Received: from [10.89.10.227] ([172.58.183.226])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-450426be56dsm1590055b6e.18.2025.11.10.02.55.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Nov 2025 02:55:32 -0800 (PST)
Message-ID: <f84fe693-527c-4d76-a9a2-500ca64ecae8@linaro.org>
Date: Mon, 10 Nov 2025 11:55:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] accel/tcg: Trace tb_flush() and tb_gen_code() buffer
 overflow
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250925035610.80605-1-philmd@linaro.org>
 <5e4627f8-ae34-4b02-8540-a8fc008e0816@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <5e4627f8-ae34-4b02-8540-a8fc008e0816@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22e.google.com
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

On 10/29/25 18:56, Philippe Mathieu-Daudé wrote:
> On 25/9/25 05:56, Philippe Mathieu-Daudé wrote:
>> Add trace events to better understand the changes introduced
>> by the "accel/tcg: Improve tb_flush usage" series recently
>> merged.
>>
>> Philippe Mathieu-Daudé (2):
>>    accel/tcg: Trace tb_flush() calls
>>    accel/tcg: Trace tb_gen_code() buffer overflow
>>
>>   accel/tcg/tb-maint.c      | 3 ++-
>>   accel/tcg/translate-all.c | 3 +++
>>   accel/tcg/trace-events    | 4 ++++
>>   3 files changed, 9 insertions(+), 1 deletion(-)
>>
> 
> ping?

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

and queued.

r~

