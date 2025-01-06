Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC237E77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 21:48:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUuxi-0001I4-9A; Mon, 06 Jan 2025 16:48:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tUuxh-0001Hu-Ck
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 16:48:37 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tUuxf-0005dk-Q7
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 16:48:37 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-436326dcb1cso99204075e9.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 13:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736200113; x=1736804913; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=93UlrtUJyq7ln9wqC8Bu72dOSDOsCtROuLlpX6jUZSc=;
 b=W2nocgq2wMxI9uIqlm/x4RxGPcKTQchbLUTEToX5zxrzCfhOatLanrOMh8GAtZtyfQ
 pzwWKAobOKkcsuop9f9YHHV8bPLxtKmCC5YLmOf607FmSz+bWWjopj2JG9S0nRZMPHzw
 wooqLD8Sfs7+greWXrjTM0iJ99Bi4YlQYg/ROM1qf9lJb1tWWVCZFcnkGYPpq85opew/
 L40qdSHrOucReN4lXbzjAolcoG3iRDFJgI2pVg93xaR+0hW803L1ULyBF1QPhcjAw/LU
 uN3WhoZuPvIj0arMEy4llNRJTLKGY6PKiuyTCiBrQxv/Cc/0+CvfgnGCyHxA0FPUD4J+
 c/qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736200113; x=1736804913;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=93UlrtUJyq7ln9wqC8Bu72dOSDOsCtROuLlpX6jUZSc=;
 b=KHCrVDly0k3prHSDuE3q427mQGBx7RYIoKu2A1no5nEE9wSvcQS/6wu+KYnwCjkYQ6
 foq7fNEvaMaFFvmWzsKTZYz9tN1Dzy3MzTAhRe+wqdvmLDtP2r2iLSQDWKmQcwwn/7bM
 CWdtzcHHyPS/fFjoYCHPoZ3KPU9DbotW5cZQEyUB5ZzaKRZbeXgU+VF7Xa2wUXkGYQi2
 QNDzVTB9Ii1KAfnUzeLnIRGlyBgGIWLdyHOLMpSCyjIK2qJ+JGz7cOLZ+ZirbqXdRllF
 FYh05b5qnACwZfMYW/YgzcGgU1RZy8YeqL3yW+VVV5pK89EaNfyijSrQX04HCbKcebT+
 4wrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkk5MnmtlEjY9Jup3CJEUO/OfTS6B7Gy5CP/48oXDKowM4dtCOUFbdGWUaePopcvwPnmlPUQtoSOEj@nongnu.org
X-Gm-Message-State: AOJu0YxbCZ3Td97OoUeOe8aHCeUzxUNC7SWOZzd/AecnBBhhaXn0MSgp
 ZJhuC364F6DDUlUKwXPZDPrsnm3fFYPQ8Atc5V7rxqGOM1n3O/9UYukJgLbhaA+zNRgyqYr/Dna
 rDXc=
X-Gm-Gg: ASbGncsKezb3LG9aYjfWh3iINN7LIcifqK+mXkqhmbF/jd8nvR1E2rUrCaEFvulMSvb
 fcZEPEqfv2UugISqnZ/PtWQWrgxEm8tM0QZkmbEQkfCgWaG0+Zss699pe/qYWTMUm8ljNT5wBcQ
 zmRG7NWcWjchlRrauQZtdZ0T+PulMNFjrRydYHoFO0ihX16vou5EtjbDgYT5B+pLFVaDPXTIb7s
 zLKc1CiRYIa4crGk+/3U5WkaO9KSJKjXXS3KmN3DmFUpZthMgeDWaBfL1lDMO4y6A9Wn+QhIBfE
 7lw4dApsYoC/VjA9LzX8Y/ru
X-Google-Smtp-Source: AGHT+IGfL76rTgb6FMT8puq0lSPGQ9fn2r5TqGxHKda49/ZEMnQhvXgRPTxAYpHR0wlwXyMgcj3QIA==
X-Received: by 2002:a5d:584e:0:b0:385:ee59:44f1 with SMTP id
 ffacd0b85a97d-38a221fad17mr52588921f8f.20.1736200112948; 
 Mon, 06 Jan 2025 13:48:32 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c89e2b0sm49721507f8f.82.2025.01.06.13.48.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jan 2025 13:48:32 -0800 (PST)
Message-ID: <8d4faa05-3273-40c0-adcc-c5f2f739a12e@linaro.org>
Date: Mon, 6 Jan 2025 22:48:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/73] tcg: Merge TCG_TARGET_HAS_bswap*
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
 <20250102180654.1420056-25-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250102180654.1420056-25-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 2/1/25 19:06, Richard Henderson wrote:
> Merge not only the i32 and i64 alternatives, but all
> of the different input bit sizes as well.  For each
> tcg target they are all the same.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h            | 10 +++++-----
>   tcg/aarch64/tcg-target-has.h     |  6 +-----
>   tcg/arm/tcg-target-has.h         |  3 +--
>   tcg/i386/tcg-target-has.h        |  6 +-----
>   tcg/loongarch64/tcg-target-has.h |  6 +-----
>   tcg/mips/tcg-target-has.h        |  6 +-----
>   tcg/ppc/tcg-target-has.h         |  6 +-----
>   tcg/riscv/tcg-target-has.h       |  6 +-----
>   tcg/s390x/tcg-target-has.h       |  6 +-----
>   tcg/sparc64/tcg-target-has.h     |  6 +-----
>   tcg/tcg-has.h                    |  3 ---
>   tcg/tci/tcg-target-has.h         |  6 +-----
>   tcg/tcg-op.c                     | 10 +++++-----
>   tcg/tcg.c                        |  7 ++-----
>   tcg/tci.c                        |  9 ---------
>   tcg/tci/tcg-target.c.inc         | 10 +++++-----
>   16 files changed, 27 insertions(+), 79 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


