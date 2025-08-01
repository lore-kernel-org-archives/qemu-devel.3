Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E69C87FD3
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 01:45:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uheop-0008KK-Jz; Thu, 31 Jul 2025 21:44:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhenP-00065O-Uq
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 21:42:59 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhenN-0001q3-FT
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 21:42:55 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-24003ed822cso7012475ad.1
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 18:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754012570; x=1754617370; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9Id2YJOTeQvtKjzOIn16WgwB8L5PpAfosXZIlx8bJvw=;
 b=LeyIvecNcF6nQ0GtorA2GVo2eHv6N89rLTq7ZmrKNNSM+gTRhsunYoXQq4YXImgT+M
 ghREivx4PeOrtnvkEOYiGdKvauT7donQep2LgrKW3dxGhIyVV0unqYiblx7MIs+myXeY
 8e+XgSzz0cIHLhItonS2pEZpFQVK91TNW/GwfetwbMhWdNBNJzyy1OUGrb8eqyZ6bQEH
 tar0TnpTuvo0VrDg6zvGKyDD54K1QZPheyINV+3GQErc1Fucp40ecl6TCDhx1JHpDe4B
 Kd6CGJw2ONgzE6+4kk372xFTdVf8h0LD15jngt4Qkxdo0TmMjPI69COIZbHH+lm6q3qE
 HRTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754012570; x=1754617370;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9Id2YJOTeQvtKjzOIn16WgwB8L5PpAfosXZIlx8bJvw=;
 b=AZUih8QopIFhE7VqZAKkk8gwdGxHrBJXEF9SIgfXOBES1rB6TWtZLO45ofaprExbLm
 zQVTYoATObsKaXZ2K48RjeQLYqPJqOXILqjKi9CEwoioT5iMpigTIJrv/yHU2Sj5OMc3
 SLBrb/iNnFTpL8Nf/bGo2NicGvolZgI/gI6bVE7ImoQiZaQ/xYxap/8wAvMpBERawsa4
 Uzet7yEewiYbs9zx9XPBqT7EPywq13Kyje1xj085xthDVsb35OWI53Az6uk6tFrRBUkv
 zCz65mg0s+4dLdy9ruM3YN/06/IK3wiw7gCt7wHVlO7oiB9eOpWUuxwWJvnD1Hc4ixIm
 mzEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxyNodRZykw7D7tPhGTCOCOIL8HTt5ENu2rmxsbJLamLpifE+XjYTCF5fjF/3TXwnNsfH39YsdADAz@nongnu.org
X-Gm-Message-State: AOJu0Yz+8mHLCQjqyWP3ep6qTI7c7Y5DP6ej8pkqaWMAD+RNrv/OZpOd
 qobAeYi1Tb7rsT0fljT6X44hKKrSYnju16xF0rg5gPRff50G7BIUGLJn86BAA8DINwcBptzQMv7
 t9njB
X-Gm-Gg: ASbGncvLV6Xx5lmssNl1G5jdzjT3PkCGA2tu1U5/0nQOPoo5t3YpV814KnAAPqtA/Ji
 r5BRWtAgCVWIcm/5RcScQNnB0RN2/2E0DyF5u/euq/bi2uuA8MmIHF8SHkzeNn55HVQB3yy5qr2
 R/dKZHwqbdSMNcPOEjcFrD6ns0Knl67vlxocYeUkv6SrXNq++4aONfIRhuhC4GXf9c/CIZ4U8Sn
 TjToEo6jwleZ5dInv1S/1kxTj9THSYrH9R9N+rRndJAIIBGbhba0gim9C/3dEVKeeR6ew32jzId
 2z4xzgyJI0eG4Abbt5Kq6wsJOmz8FVKNolZ1RJYkkcvMdr9wRfsrX4j5awstCh+WvxzeTSQVrCa
 I210goCkK3JYR2P1TDRF4xKhHRYqpnYPpc/w=
X-Google-Smtp-Source: AGHT+IGm0SeMH3GfVnuLJm3ClD7wh6TtWC2aLZkvPzPRNd6qx34i3RpKW9lSw7YN4vKTAdKu+LspKQ==
X-Received: by 2002:a17:903:4b0d:b0:236:6fbb:a5f3 with SMTP id
 d9443c01a7336-24096b48c1amr126154945ad.40.1754012570468; 
 Thu, 31 Jul 2025 18:42:50 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e8ab0a00sm28932055ad.177.2025.07.31.18.42.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 18:42:49 -0700 (PDT)
Message-ID: <7460cc8b-c839-4b09-856e-15c253770bb3@linaro.org>
Date: Thu, 31 Jul 2025 18:42:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] semihosting/syscalls: compile once in system and
 per target for user mode
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, philmd@linaro.org,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>
References: <20250730220621.1142496-1-pierrick.bouvier@linaro.org>
 <20250730220621.1142496-2-pierrick.bouvier@linaro.org>
 <eac843f3-e920-4c6d-9c45-45087b41fb78@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <eac843f3-e920-4c6d-9c45-45087b41fb78@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

On 7/31/25 4:13 PM, Richard Henderson wrote:
> On 7/31/25 08:06, Pierrick Bouvier wrote:
>> We replace target_ulong mechanically by uint64_t.
>> We can't compile (easily) this code once for user, as it relies on
>> various target/function types, so leave it in specific_ss for user mode.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    include/semihosting/syscalls.h | 29 ++++++-----
>>    semihosting/arm-compat-semi.c  |  1 +
>>    semihosting/syscalls.c         | 89 +++++++++++++++++-----------------
>>    semihosting/meson.build        |  4 +-
>>    4 files changed, 62 insertions(+), 61 deletions(-)
> 
> We can at least use vaddr for the pointers, like fname.
> 
> I see syscalls.c already uses uint64_t in many of those places, but that can be a separate
> cleanup -- we don't need to add more.
>

I preferred to do a mechanical change, given where it's used. Anyway, 
I'll replace that using vaddr where appropriate.

> 
> r~


