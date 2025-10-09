Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8121CCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 16:49:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6tp1-00029F-Eg; Thu, 09 Oct 2025 12:48:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6toy-00028Q-Ml
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 12:48:52 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6tos-0004vZ-Jj
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 12:48:52 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-3304a57d842so1087214a91.3
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 09:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760028524; x=1760633324; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2BfWnLYMvEFqLkbTJMAzVQIPHIxrSLXwuEKVgi6pRpk=;
 b=b2i0375gfQxuxlPN0FhN5Mq8z0p35+3gW4qFlAO4dTvSNuMbqanoxtgGg2eKp0qYX9
 +l9qtYXosNZZJOO2CVo5aD2PKsPhzYE7Dz4+V56SMhYQ67+1GtQphkdp0J201VfKH90P
 /E21sh0LVkemX98g4f2HIndhlhvR+M+mtq9x02VenKyeB4hZq45UwXHRCV70+IOSn+za
 Lq+ulvJCu3/xcSdljoy05cXKYZYClf0LluWqeygE0dA8a79p+cXVRrhVWmA+llncc0wA
 MK3PuH4XjP+Dztic6SWeHNxEDBxVqHINSvVX4g5twW1bIZL54u3Aa5za4g0JtCvFQxe3
 rPZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760028524; x=1760633324;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2BfWnLYMvEFqLkbTJMAzVQIPHIxrSLXwuEKVgi6pRpk=;
 b=FSXRnG35j3zryoTn/3pwCdakZ5n8JUUtJYHM8+iB3FoZmFDSl0l8jtrAh2QCEixPVS
 58Bm3HRhMhbi2nVrfqqxu+ODHJuqLMu/lTwXj1awnCYRzcJxQY4ThRAyKlqY6Q7+wi2E
 jXpTSVYPQs3o3hVQ7ZnZDh0nWk6VpdWaSgItKOZYPLhEydkmCETrj5TnzIvtyaC4l+FT
 JvqM+iC3wbOGCClxXGBQy2/m0o3pkbxVM1wxoT5NxSIbib+d7UXRbwGCv5nQkJ/4P7ak
 vMJTXVwnK+goM0LpRPPQodR2n4uVWeOhmw6R8pD1gdCeZMv6cqJnOKBd3OiNcunH27Bp
 sdow==
X-Gm-Message-State: AOJu0YyfCmCO6WQkcPngZUHR9IcMUUEpPS4p5aLwueqFksOk7katuMJk
 0aWcvua87IV5ZiEOYojYTdQd3Z3+9LdyZxs99MkeJeY/h6hXgSygMlE0SRoTt38O0T9MoiQRRou
 rYm42I0g=
X-Gm-Gg: ASbGncuSAvmC3BZGaTo2p0mNxHbWlnH1PoJH9Weeo7VVrDd43AyNPnNMkp5kGhh0U8D
 4hav2Tqf3nnyjMoWGHfkrXgAsnnucSX8HF72zJ7mGny7M1FR2o2aGD+JB66jOSk5XzA+5o0FTiK
 Uw6tBLzMTpNeyF5pqVISIjtVhq7F1dYZ+5SWUVeOAiYqd3/wN1pAUZ1yKH+7lzUFC8yblxYIwwh
 +lra5kScYT4Nu+16lZuf6zbdM7G202qCXkMoFUMphwMoRr8Cs7dcCQdIqIjxZyMYHN3R9db2xgH
 4S+GeMOAIJiWSBZ9wrsawUf3wkJOIxVndWOA7EeRd2kC1dmP7UXi2ZOLupiMxqBP/l8dMq36ttm
 0oL1sv9p9vx9z3ElAeT+fyofYhaSyCgbuh+zp6+i0H671qu4LZUlET5NNpIO11ZxroEUU2lTkAG
 4=
X-Google-Smtp-Source: AGHT+IHLGxvat/CL2kgkyyBSu84GLQGNwVuCN1l/kRi9V1g6/LRqfyrwvaPumMUwJVUy2GYs9XBv3w==
X-Received: by 2002:a17:90b:4b06:b0:32e:9f1e:4ee4 with SMTP id
 98e67ed59e1d1-33b513b2d70mr11447703a91.17.1760028523801; 
 Thu, 09 Oct 2025 09:48:43 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33b61a392cdsm365958a91.7.2025.10.09.09.48.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 09:48:43 -0700 (PDT)
Message-ID: <d6248333-9f2a-4e2e-bdac-40db92a46138@linaro.org>
Date: Thu, 9 Oct 2025 09:48:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/10] target/openrisc: Remove target_ulong use in
 raise_mmu_exception()
To: qemu-devel@nongnu.org
References: <20251009081903.13426-1-philmd@linaro.org>
 <20251009081903.13426-7-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251009081903.13426-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/9/25 01:18, Philippe Mathieu-Daudé wrote:
> TCGCPUOps::tlb_fill() handler provides a vaddr type (since commit
> 7510454e3e7 "cpu: Turn cpu_handle_mmu_fault() into a CPUClass hook").
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/openrisc/mmu.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

